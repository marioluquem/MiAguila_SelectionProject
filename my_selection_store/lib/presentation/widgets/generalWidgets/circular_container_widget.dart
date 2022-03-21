import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';

class CircularContainer extends StatelessWidget {
  final double size;
  final double aspectRatio;
  final Widget child;
  Color? backgroundColor;
  CircularContainer(
      {Key? key,
      required this.size,
      required this.child,
      this.aspectRatio = 1,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: ClipOval(
          child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Container(
            color: backgroundColor ?? Constants.mainColor, child: child),
      )),
    );
  }
}
