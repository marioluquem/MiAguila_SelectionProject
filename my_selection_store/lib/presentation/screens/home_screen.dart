import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/dynamiclinks_cubit.dart';
import '../../business_logic/cubit/internet_cubit.dart';
import '../../data/models/product_model.dart';
import '../../business_logic/cubit/products_cubit.dart';
import '../../helpers/constants.dart';
import '../../helpers/routes.dart';
import '../../helpers/utils.dart';
import '../widgets/homeWidgets/quick_view_cart_widget.dart';

import '../widgets/homeWidgets/featured_products_widget.dart';
import '../widgets/homeWidgets/scroll_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ProductsCubit productsCubit;
  late InternetCubit internetCubit;
  late DynamiclinksCubit dynamiclinksCubit;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    internetCubit = BlocProvider.of<InternetCubit>(context);
    dynamiclinksCubit = BlocProvider.of<DynamiclinksCubit>(context);
    //leemos los datos del API
    getProductsDataFromAPI();

    checkForDynamicLinks();

    super.initState();
  }

  Future getProductsDataFromAPI() async {
    try {
      //traemos los primeros 10 productos al inicializar el estado
      await productsCubit.getProductsList(1, 10);
    } catch (e) {
      print(e);
      Utils.showSnackBar(
          context: context,
          msg: 'Couln\'t read scroll products data from internet');
    }
    try {
      //traemos los productos destacados
      await productsCubit.getFeaturedProducts();
    } catch (e) {
      print(e);
      Utils.showSnackBar(
          context: context,
          msg: 'Couln\'t read featured products data from internet');
    }
  }

  checkForDynamicLinks() async {
    // Get any initial links
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    final productID = initialLink?.link.queryParameters["productID"];
    if (productID != null) {
      BlocProvider.of<DynamiclinksCubit>(context)
          .emitNewDynamicLinkReceived(int.parse(productID));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.isOrientationPortrait(context);
    //reading possible dynamiclinks
    dynamiclinksCubit.checkForDynamicLinksReceived(context);

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async => await getProductsDataFromAPI(),
          child: SizedBox(
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
    return const Positioned(
        bottom: 0,
        child: QuickCartView(
          useMaxWidth: false,
        ));
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
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, -1),
                      blurRadius: 5,
                      spreadRadius: 1)
                ]),
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
