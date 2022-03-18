import 'package:flutter/material.dart';

class Constants {
  //COLORS
  static Color mainColor = Colors.orange;
  static Color pricesColor = Colors.green;

  //IMAGES
  static String noImagePath = 'assets/imgs/no-image.jpg';

  //STYLES
  static TextStyle styleTitle({Color? textColor = Colors.black}) =>
      TextStyle(color: textColor, fontSize: 22);
}