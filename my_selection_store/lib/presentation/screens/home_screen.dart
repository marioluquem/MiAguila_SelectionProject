import 'package:flutter/material.dart';
import 'package:my_selection_store/helpers/utils.dart';

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
          child: SingleChildScrollView(
            child: Stack(
              children: [
                ScrollProductsHome(),
                isPortrait ? const FeaturedProductsHome() : Container(),
                buildShoppingCarTab(),
              ],
            ),
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
