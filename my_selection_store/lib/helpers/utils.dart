import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Utils {
  static bool isOrientationPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static void showSnackBar(
      {required BuildContext context,
      required String msg,
      int milliseconds = 500}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(milliseconds: milliseconds),
      dismissDirection: DismissDirection.endToStart,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.9),
    ));
  }

  static void scrollToMaxLength(ScrollController scrollController) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }
}
