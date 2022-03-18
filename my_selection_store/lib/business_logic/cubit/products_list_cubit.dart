import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_selection_store/business_logic/cubit/product_cubit.dart';
import 'package:my_selection_store/data/models/product_model.dart';

part 'products_list_state.dart';

//Cubit que maneja el estado la lista global de items obtenidas desde el API
class ProductslistCubit extends Cubit<ProductslistState> {
  ProductslistCubit()
      : super(ProductslistState(
            listProducts: getProducts(),
            listFeaturedProducts: getFeaturedProducts()));

  static getProducts({
    int fromIndex = 0,
    int quantity = 10,
  }) {
    return [];
  }

  static getFeaturedProducts() {
    return [];
  }
}
