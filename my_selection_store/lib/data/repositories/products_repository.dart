import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/product_model.dart';

class ProductsRepository {
  Dio dio = Dio();

  ProductsRepository();

  Future<List<ProductModel>> getProductsListFromAPI(
      int fromIndex, int quantity) async {
    List<ProductModel> listProducts = [];
    try {
      final Response rawData =
          await dio.get("https://fakestoreapi.com/products?limit=$quantity");

      listProducts = List.generate(rawData.data.length,
          (index) => ProductModel.fromJson(rawData.data[index]));
    } catch (e) {
      print(e);
      throw Exception('Error reading products data');
    }

    return listProducts;
  }

  Future<List<ProductModel>> getFeaturedProductsListFromAPI(
      int quantity) async {
    List<ProductModel> listProducts = [];
    try {
      final Response rawData =
          await dio.get("https://fakestoreapi.com/products?limit=$quantity");

      listProducts = List.generate(rawData.data.length,
          (index) => ProductModel.fromJson(rawData.data[index]));
    } catch (e) {
      print(e);
      throw Exception('Error reading products data');
    }

    return listProducts;
  }
}
