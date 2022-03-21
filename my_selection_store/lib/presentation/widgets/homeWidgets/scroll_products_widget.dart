import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/products_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/enums.dart';
import '../../../helpers/routes.dart';
import '../../../helpers/utils.dart';
import '../generalWidgets/circular_container_widget.dart';
import '../generalWidgets/grid_products.dart';

class ScrollProductsHome extends StatefulWidget {
  ScrollProductsHome({Key? key}) : super(key: key);

  @override
  State<ScrollProductsHome> createState() => _ScrollProductsHomeState();
}

class _ScrollProductsHomeState extends State<ScrollProductsHome> {
  List<ProductModel> listScrollProducts = [];
  late ProductsCubit productsCubit;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.isOrientationPortrait(context);

    return Padding(
      padding: EdgeInsets.only(
          top: isPortrait ? MediaQuery.of(context).size.height * 0.18 : 0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {},
          buildWhen: (previousState, currentState) {
            //Hacer rebuild SOLO cuando se haya actualizado la lista de productos
            return previousState.listProducts.length !=
                currentState.listProducts.length;
          },
          builder: (context, state) {
            return GridProducts(
              isLoading: state.listProductsHandlersStates
                  .contains(EnumProductsLoadingState.loadingScroll),
              listProducts: state.listProducts,
              showAddToCart: true,
              showDeleteFromCart: false,
              heroIdentifier: Constants.heroScrollIdentifier,
              animate: true,
            );
          },
        ),
      ),
    );
  }
}
