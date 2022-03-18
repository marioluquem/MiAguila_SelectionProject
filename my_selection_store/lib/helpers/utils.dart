import 'package:flutter/cupertino.dart';

class Utils {
  static bool isOrientationPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }
}
