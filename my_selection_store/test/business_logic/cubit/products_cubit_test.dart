import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  late ProductsCubit productsCubit;

  setUp(() async {
    productsCubit = ProductsCubit();
  });

  tearDown(() {
    productsCubit.close();
  });

  test("Producs Bloc debe tener un estado inicial de ProductsState", () {
    expect(productsCubit.state.runtimeType, ProductsState);
  });
}
