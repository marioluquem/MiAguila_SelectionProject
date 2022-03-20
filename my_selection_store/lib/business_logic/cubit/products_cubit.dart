import 'package:bloc/bloc.dart';

import 'package:my_selection_store/business_logic/controller/products_controller.dart';
import 'package:my_selection_store/data/models/product_model.dart';

part 'products_state.dart';

//Cubit que maneja el estado la lista global de items obtenidas desde el API
class ProductsCubit extends Cubit<ProductsState> {
  ProductsController productsController = ProductsController();

  ProductsCubit()
      : super(ProductsState(
            listProductsHandlersStates: [],
            listProducts: [],
            listFeaturedProducts: [],
            listCartProducts: [])) {
    print("en el constructor del cubit");
    //traemos los primeros 10 productos al inicializar el estado
    getProductsList(1, 10);
    //traemos los productos destacados
    getFeaturedProducts();
  }

  //agrega un estado a la lista de handlers de estados de los productos
  List<ProductsHandlerState> addToHandlersList(
      ProductsHandlerState loadingState) {
    return List<ProductsHandlerState>.from(state.listProductsHandlersStates)
      ..add(loadingState);
  }

  //remueve un estado de la lista de handlers de estado de los productos
  List<ProductsHandlerState> removeFromHandlersList(
      ProductsHandlerState loadingState) {
    return List<ProductsHandlerState>.from(state.listProductsHandlersStates)
      ..removeWhere((ProductsHandlerState handler) => handler == loadingState);
  }

  Future getProductsList(int indexFrom, int quantity) async {
    //mostramos el loading...
    emit(state.copyWith(
        listProductsHandlersStates:
            addToHandlersList(ProductsHandlerState.loadingScroll)));

    //traemos los productos
    List<ProductModel> newListProducts =
        await productsController.getProducts(quantity: quantity);

    //actualizamos solo la lista de productos
    emit(state.copyWith(
        listProductsHandlersStates:
            removeFromHandlersList(ProductsHandlerState.loadingScroll),
        listProducts: [...state.listProducts, ...newListProducts]));
  }

  Future getFeaturedProducts() async {
    //mostramos el loading de los featured...
    emit(state.copyWith(
        listProductsHandlersStates:
            addToHandlersList(ProductsHandlerState.loadingFeatured)));

    //traemos los productos destacados
    List<ProductModel> newFeaturedProducts =
        await productsController.getFeaturedProducts(quantity: 5);

    //actualizamos solo la lista de productos destacados
    emit(state.copyWith(
        listProductsHandlersStates:
            removeFromHandlersList(ProductsHandlerState.loadingFeatured),
        listFeaturedProducts: newFeaturedProducts));
  }

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
}
