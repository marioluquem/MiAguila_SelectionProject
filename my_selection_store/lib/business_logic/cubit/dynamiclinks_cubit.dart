import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';

part 'dynamiclinks_state.dart';

class DynamiclinksCubit extends Cubit<DynamiclinksState> {
  late ProductsCubit productsCubit;
  DynamiclinksCubit() : super(DynamiclinksWaiting()) {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      int productID =
          int.parse(dynamicLinkData.link.queryParameters["productID"] ?? '0');
      emitNewDynamicLinkReceived(productID);
    }).onError((error) {
      // Handle errors
    });
  }

  void emitNewDynamicLinkReceived(int productID) {
    emit(DynamicLinkReceived(productID: productID));
  }

  void emitDynamicLinkWaiting() {
    emit(DynamiclinksWaiting());
  }
}
