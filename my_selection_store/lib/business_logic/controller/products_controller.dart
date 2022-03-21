import 'package:my_selection_store/locator.dart';

import '../../data/models/product_model.dart';
import '../../data/repositories/products_repository.dart';

class ProductsController {
  ProductsController();

  Future<List<ProductModel>> getProducts({
    int fromIndex = 1,
    int quantity = 10,
  }) async {
    try {
      //ProductsRepository productsListRepository = ProductsRepository();
      return await locator
          .get<ProductsRepository>()
          .getProductsListFromAPI(fromIndex, quantity);
    } catch (e) {
      rethrow;
    }
  }

  getFeaturedProducts({
    int quantity = 10,
  }) async {
    try {
      //ProductsRepository featuredProductsListRepository = ProductsRepository();
      return await locator
          .get<ProductsRepository>()
          .getFeaturedProductsListFromAPI(quantity);
    } catch (e) {
      rethrow;
    }
  }
}
