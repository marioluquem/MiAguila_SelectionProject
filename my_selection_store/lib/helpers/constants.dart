import 'package:flutter/material.dart';

class Constants {
  //COLORS
  static Color mainColor = Colors.cyan;
  static Color secondaryColor = Colors.amber;
  static Color secondaryColorLight = Colors.amber.shade300;
  static Color pricesColor = Colors.green;

  //IMAGES
  static String noImagePath = 'assets/imgs/no-image.jpg';

  //HERO IDENTIFIERS
  static String heroCartIdentifier = "Cart";
  static String heroScrollIdentifier = "Scroll";

  //STYLES
  static TextStyle styleTitle({Color? textColor = Colors.black}) =>
      TextStyle(color: textColor, fontSize: 22);
}
