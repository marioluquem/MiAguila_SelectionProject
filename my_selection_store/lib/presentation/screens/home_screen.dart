import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/helpers/utils.dart';
import 'package:my_selection_store/presentation/widgets/homeWidgets/quick_view_cart_widget.dart';

import '../widgets/homeWidgets/featured_products_widget.dart';
import '../widgets/homeWidgets/scroll_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.isOrientationPortrait(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              buildScrollProducts(isPortrait, context),
              buildFeaturedProducts(isPortrait),
              buildQuickCartView(),
              shoppingCartButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding buildScrollProducts(bool isPortrait, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: isPortrait //&& !isInCartPage
              ? MediaQuery.of(context).size.height * 0.08
              : 0),
      child: ScrollProductsHome(),
    );
  }

  Widget buildFeaturedProducts(bool isPortrait) {
    return isPortrait
        ? const FeaturedProductsHome()
        : Container(); //solo muestra destacados en Portrait
  }

  Widget buildQuickCartView() {
    return const Positioned(bottom: 0, child: QuickCartView());
  }

  Positioned shoppingCartButton(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.shoppingCartPath);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Constants.secondaryColor,
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(100)),
            ),
            height: 100,
            padding: const EdgeInsets.only(left: 20, top: 20),
            width: MediaQuery.of(context).size.width * 0.22,
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 50,
            ),
          ),
        ));
  }
}
