part of 'products_cubit.dart';

//Estado del cubit de la lista global de items del API
class ProductsState {
  final List<EnumProductsLoadingState> listProductsHandlersStates;
  final List<ProductModel> listProducts;
  final List<ProductModel> listFeaturedProducts;
  final List<ProductModel> listCartProducts;
  ProductModel selectedDetailProduct;

  ProductsState(
      {required this.listProductsHandlersStates,
      required this.listProducts,
      required this.listFeaturedProducts,
      required this.listCartProducts,
      required this.selectedDetailProduct});

  ProductsState copyWith(
      {List<EnumProductsLoadingState>? listProductsHandlersStates,
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

  Map<String, dynamic> toMap() {
    return {
      'listProductsHandlersStates': [],
      'listProducts': listProducts.map((x) => x.toJson()).toList(),
      'listFeaturedProducts':
          listFeaturedProducts.map((x) => x.toJson()).toList(),
      'listCartProducts': listCartProducts.map((x) => x.toJson()).toList(),
      'selectedDetailProduct': selectedDetailProduct.toJson(),
    };
  }

  factory ProductsState.fromMap(Map<String, dynamic> map) {
    return ProductsState(
      listProductsHandlersStates: [],
      listProducts: List<ProductModel>.from(
          map['listProducts']?.map((x) => ProductModel.fromJson(x))),
      listFeaturedProducts: List<ProductModel>.from(
          map['listFeaturedProducts']?.map((x) => ProductModel.fromJson(x))),
      listCartProducts: List<ProductModel>.from(
          map['listCartProducts']?.map((x) => ProductModel.fromJson(x))),
      selectedDetailProduct:
          ProductModel.fromJson(map['selectedDetailProduct']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsState.fromJson(String source) =>
      ProductsState.fromMap(json.decode(source));
}
