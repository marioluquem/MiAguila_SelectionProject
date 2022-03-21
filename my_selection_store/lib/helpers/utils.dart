import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import '../business_logic/cubit/dynamiclinks_cubit.dart';
import '../business_logic/cubit/products_cubit.dart';
import '../data/models/product_model.dart';
import 'routes.dart';

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

  static Future<String> createDynamicLink(
    BuildContext context,
    String title,
    ProductModel product,
  ) async {
    String uriPrefix = "https://miaguilastorejobtest.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      //add urlPrefix as per point 3.2
      uriPrefix: uriPrefix,
      //add link as per point 4.7
      link: Uri.parse('$uriPrefix/room/?productID=${product.id}'),
      androidParameters: const AndroidParameters(
        //android/app/build.gradle
        packageName: 'com.marioluque.miaguilastorejobtest',
        minimumVersion: 0,
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: title, imageUrl: Uri.parse(product.image)),
      iosParameters: const IOSParameters(
        bundleId: 'com.marioluque.miaguilastorejobtest',
        minimumVersion: '0',
      ),
    );

    final ShortDynamicLink shortLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri url = shortLink.shortUrl;

    return url.toString();
  }

  static Future<void> share(
      String title, String text, String linkUrl, String chooserTitle) async {
    await FlutterShare.share(
        title: title, text: text, linkUrl: linkUrl, chooserTitle: chooserTitle);
  }
}
