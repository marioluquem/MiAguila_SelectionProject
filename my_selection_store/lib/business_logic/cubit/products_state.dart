part of 'products_cubit.dart';

enum ProductsHandlerState {
  loadingAll,
  loadingFeatured,
  loadingScroll,
  loadingCart,
}

//Estado del cubit de la lista global de items del API
class ProductsState {
  final List<ProductsHandlerState> listProductsHandlersStates;
  final List<ProductModel> listProducts;
  final List<ProductModel> listFeaturedProducts;
  final List<ProductModel> listCartProducts;
  ProductModel? selectedDetailProduct;

  ProductsState(
      {required this.listProductsHandlersStates,
      required this.listProducts,
      required this.listFeaturedProducts,
      required this.listCartProducts,
      ProductModel? selectedDetailProduct});

  ProductsState copyWith(
      {List<ProductsHandlerState>? listProductsHandlersStates,
      List<ProductModel>? listProducts,
      List<ProductModel>? listFeaturedProducts,
      List<ProductModel>? listCartProducts,
      ProductModel? selectedDetailProduct}) {
    return ProductsState(
        listProductsHandlersStates:
            listProductsHandlersStates ?? this.listProductsHandlersStates,
        listProducts: listProducts ?? this.listProducts,
        listFeaturedProducts: listFeaturedProducts ?? this.listFeaturedProducts,
        listCartProducts: listCartProducts ?? this.listCartProducts,
        selectedDetailProduct:
            selectedDetailProduct ?? this.selectedDetailProduct);
  }
}
