import 'package:get_it/get_it.dart';
import 'package:my_selection_store/business_logic/controller/products_controller.dart';
import 'package:my_selection_store/data/repositories/products_repository.dart';

final locator = GetIt.instance;
void setupDependenciesInjection() {
  locator.registerLazySingleton<ProductsController>(() => ProductsController());
  locator.registerLazySingleton<ProductsRepository>(() => ProductsRepository());
}
