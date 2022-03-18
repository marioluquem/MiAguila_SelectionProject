import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

//Cubit que maneja el estado un producto
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductState());
}
