import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_selection_store/business_logic/cubit/product_cubit.dart';

part 'mycartlist_state.dart';

//Cubit que maneja el estado la lista del carrito de compras
class MycartlistCubit extends Cubit<MycartlistState> {
  MycartlistCubit() : super(MycartlistState(listShoppingCart: []));
}
