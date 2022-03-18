import 'package:flutter/material.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/utils.dart';
import 'package:my_selection_store/presentation/widgets/home/quick_view_cart_widget.dart';

import '../widgets/home/featured_products_widget.dart';
import '../widgets/home/scroll_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.isOrientationPortrait(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ScrollProductsHome(),
              isPortrait ? const FeaturedProductsHome() : Container(),
              Positioned(bottom: 0, child: QuickCartView()),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.mainColor,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(100)),
                    ),
                    height: 100,
                    padding: EdgeInsets.only(left: 20, top: 20),
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 50,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  buildScrollProducts() {
    return Container();
  }

  buildShoppingCarTab() {
    return Container();
  }
}
