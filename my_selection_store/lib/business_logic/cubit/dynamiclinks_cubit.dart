import 'package:bloc/bloc.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'products_cubit.dart';
import '../../data/models/product_model.dart';
import '../../helpers/routes.dart';

part 'dynamiclinks_state.dart';

class DynamiclinksCubit extends Cubit<DynamiclinksState> {
  final ProductsCubit productsCubit;
  DynamiclinksCubit({required this.productsCubit})
      : super(DynamiclinksWaiting()) {
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

  Future checkForDynamicLinksReceived(BuildContext context) async {
    DynamiclinksCubit dynamiclinksCubit = context.watch<DynamiclinksCubit>();
    if (state is DynamicLinkReceived) {
      int idDynamic = (state as DynamicLinkReceived).productID;
      try {
        ProductModel productFound = productsCubit.state.listProducts
            .firstWhere((ProductModel element) => element.id == idDynamic);

        await pushDetailPageFromDynamicLink(context, productFound);
      } catch (e) {
        print(e);
        print('Didn\'t found the product with ID: $idDynamic');
      }
    }
  }

  Future pushDetailPageFromDynamicLink(
      BuildContext context, ProductModel product) async {
    emitDynamicLinkWaiting(); //volvemos a la normalidad (ya no tiene un link pendiente)
    productsCubit
        .setDetailProduct(product); //asignamos el producto a ver en detalle

    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, MyRoutes.detailPath,
          arguments: ['']); //vamos al detalle
    });
  }
}
