import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_selection_store/presentation/screens/home_screen.dart';

class MyRoutes {
  static const String homePath = 'home_screen';
  static const String detailPath = 'detail_screen';
  static const String myCartPath = 'my_cart_screen';

  static getRoutes(RouteSettings settings) {
    Widget screen;
    switch (settings.name) {
      case homePath:
        screen = const HomeScreen();
        break;
      default:
        screen = const HomeScreen();
        break;
    }
    return MaterialPageRoute(builder: (context) => screen);
  }
}
