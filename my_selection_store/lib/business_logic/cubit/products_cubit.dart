import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_selection_store/locator.dart';
import '../../helpers/utils.dart';

import '../../data/models/product_model.dart';
import '../../helpers/enums.dart';
import '../controller/products_controller.dart';

part 'products_state.dart';

//Cubit que maneja el estado la lista global de items obtenidas desde el API
class ProductsCubit extends Cubit<ProductsState> with HydratedMixin {
  //ProductsController productsController = ProductsController();

  ProductsCubit()
      : super(ProductsState(
            listProductsHandlersStates: [],
            listProducts: [],
            listFeaturedProducts: [],
            listCartProducts: [],
            selectedDetailProduct: ProductModel.empty()));

  ///****************************  UTILS  *********************************/

  //Util: agrega un estado a la lista de handlers de estados de los productos
  List<EnumProductsLoadingState> addToHandlersList(
      EnumProductsLoadingState loadingState) {
    return List<EnumProductsLoadingState>.from(state.listProductsHandlersStates)
      ..add(loadingState);
  }

  //Util: remueve un estado de la lista de handlers de estado de los productos
  List<EnumProductsLoadingState> removeFromHandlersList(
      EnumProductsLoadingState loadingState) {
    return List<EnumProductsLoadingState>.from(state.listProductsHandlersStates)
      ..removeWhere(
          (EnumProductsLoadingState handler) => handler == loadingState);
  }

  ///****************************  Obtiene las listas de productos del API a traves del controller  *********************************/

  Future getProductsList(int indexFrom, int quantity) async {
    //mostramos el loading...
    emit(state.copyWith(
        listProductsHandlersStates:
            addToHandlersList(EnumProductsLoadingState.loadingScroll)));

    if (state.listProducts.isEmpty) {
      print("Lista de productos vacía, leemos el API");

      try {
        //traemos los productos
        List<ProductModel> newListProducts = await locator
            .get<ProductsController>()
            .getProducts(quantity: quantity);

        //actualizamos solo la lista de productos
        emit(state.copyWith(
            listProductsHandlersStates:
                removeFromHandlersList(EnumProductsLoadingState.loadingScroll),
            listProducts: [...state.listProducts, ...newListProducts]));
      } catch (e) {
        print(e);
        emit(state.copyWith(
          listProductsHandlersStates:
              removeFromHandlersList(EnumProductsLoadingState.loadingScroll),
        ));
        rethrow;
      }
    } else {
      print("Lista de productos llena, leida desde storage");
      //actualizamos solo la lista de productos
      emit(state.copyWith(
          listProductsHandlersStates:
              removeFromHandlersList(EnumProductsLoadingState.loadingScroll),
          listProducts: List.from(state.listProducts)));
    }
  }

  Future getFeaturedProducts() async {
    //mostramos el loading de los featured...
    emit(state.copyWith(
        listProductsHandlersStates:
            addToHandlersList(EnumProductsLoadingState.loadingFeatured)));

    try {
      //traemos los productos destacados
      List<ProductModel> newFeaturedProducts = await locator
          .get<ProductsController>()
          .getFeaturedProducts(quantity: 5);

      //actualizamos solo la lista de productos destacados
      emit(state.copyWith(
          listProductsHandlersStates:
              removeFromHandlersList(EnumProductsLoadingState.loadingFeatured),
          listFeaturedProducts: newFeaturedProducts));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        listProductsHandlersStates:
            removeFromHandlersList(EnumProductsLoadingState.loadingFeatured),
      ));
      rethrow;
    }
  }

  ///****************************  Agrega/Remueve un producto al/del carrito  *********************************/

  void addProductToCart(ProductModel product) {
    List<ProductModel> newCartList = List.from(state.listCartProducts);
    newCartList.add(product);
    emit(state.copyWith(listCartProducts: newCartList));
  }

  void removeProductFromCart(int index) {
    List<ProductModel> newCartList = List.from(state.listCartProducts);
    newCartList.removeAt(index);
    emit(state.copyWith(listCartProducts: newCartList));
  }

  ///****************************  Selecciona un producto para el detalle  *********************************/

  void setDetailProduct(ProductModel product) {
    emit(state.copyWith(selectedDetailProduct: product));
  }

  ///****************************  MIXINS OVERRIDES para guardar los daos en local  *********************************/
  @override
  ProductsState? fromJson(Map<String, dynamic> json) {
    return ProductsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ProductsState state) {
    return state.toMap();
  }
}
