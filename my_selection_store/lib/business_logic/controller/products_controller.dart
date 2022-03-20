import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/data/repositories/products_repository.dart';

class ProductsController {
  ProductsController();

  Future<List<ProductModel>> getProducts({
    int fromIndex = 1,
    int quantity = 10,
  }) async {
    ProductsRepository productsListRepository = ProductsRepository();
    return await productsListRepository.getProductsListFromAPI(
        fromIndex, quantity);
  }

  getFeaturedProducts({
    int quantity = 10,
  }) async {
    ProductsRepository featuredProductsListRepository = ProductsRepository();
    return await featuredProductsListRepository
        .getFeaturedProductsListFromAPI(quantity);
  }
}
