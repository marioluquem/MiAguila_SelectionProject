import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/dynamiclinks_cubit.dart';
import '../../business_logic/cubit/products_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/enums.dart';
import '../widgets/generalWidgets/grid_products.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late ProductsCubit productsCubit;
  late DynamiclinksCubit dynamiclinksCubit;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    dynamiclinksCubit = BlocProvider.of<DynamiclinksCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //reading possible dynamiclinks
    dynamiclinksCubit.checkForDynamicLinksReceived(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            title(text: 'My Shopping Cart'),
            Expanded(
              child: BlocConsumer<ProductsCubit, ProductsState>(
                listener: (context, state) {},
                buildWhen: (previousState, currentState) {
                  //Hacer rebuild SOLO cuando se haya actualizado la lista de productos
                  return previousState.listCartProducts.length !=
                      currentState.listCartProducts.length;
                },
                builder: (context, state) {
                  return state.listCartProducts.isEmpty
                      ? const Center(
                          child: Text(
                            'Your shopping cart is empty. \n\nTry adding some products!',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : GridProducts(
                          isLoading: state.listProductsHandlersStates
                              .contains(EnumProductsLoadingState.loadingCart),
                          listProducts: state.listCartProducts,
                          showAddToCart: false,
                          showDeleteFromCart: true,
                          heroIdentifier: Constants.heroCartIdentifier,
                          animate:
                              false, //No hace animacion de EaseIn, porque estamos haciendo ya la animacion del hero
                          isInShoppingCart: true,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title({required String text, Function? callback}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          color: Constants.secondaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 5),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 100),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 30)),
        ),
        Center(
          child: Text(
            text,
            style: Constants.styleTitle(textColor: Colors.white),
          ),
        ),
      ]),
    );
  }
}
