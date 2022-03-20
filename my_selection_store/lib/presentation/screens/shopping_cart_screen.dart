import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/grid_products.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late ProductsCubit productsCubit;
  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              .contains(ProductsHandlerState.loadingCart),
                          listProducts: state.listCartProducts,
                          showAddToCart: false,
                          showDeleteFromCart: true,
                          heroIdentifier: Constants.heroCartIdentifier,
                          animate:
                              false, //porque estamos haciendo ya la animacion del hero
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
          color: Constants.mainColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100))),
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
