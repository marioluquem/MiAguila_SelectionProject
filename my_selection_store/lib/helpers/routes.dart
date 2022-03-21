import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../presentation/screens/detail_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/shopping_cart_screen.dart';

class MyRoutes {
  static const String homePath = 'home_screen';
  static const String detailPath = 'detail_screen';
  static const String shoppingCartPath = 'shopping_cart_screen';

  static getRoutes(RouteSettings settings) {
    Widget screen;
    switch (settings.name) {
      case homePath:
        screen = const HomeScreen();
        break;
      case detailPath:
        final args = settings.arguments as List<dynamic>;
        //final product = args[0];
        final idHero = args[0];
        screen = DetailScreen(
          idHero: idHero,
        );
        break;
      case shoppingCartPath:
        screen = const ShoppingCartScreen();
        break;
      default:
        screen = const HomeScreen();
        break;
    }
    return MaterialPageRoute(builder: (context) => screen);
  }
}
