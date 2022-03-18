part of 'productslist_cubit.dart';

//Estado del cubit de la lista global de items del API
class ProductslistState {
  final List<ProductState> listProducts;
  final List<ProductState> listFeaturedProducts;
  ProductslistState(
      {required this.listProducts, required this.listFeaturedProducts});

  ProductslistState copyWith({
    List<ProductState>? listProducts,
    List<ProductState>? listFeaturedProducts,
  }) {
    return ProductslistState(
      listProducts: listProducts ?? this.listProducts,
      listFeaturedProducts: listFeaturedProducts ?? this.listFeaturedProducts,
    );
  }
}
