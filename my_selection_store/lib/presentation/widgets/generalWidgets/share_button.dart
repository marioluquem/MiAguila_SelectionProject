import 'package:flutter/material.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/utils.dart';

class ShareButton extends StatefulWidget {
  ProductModel product;
  ShareButton({Key? key, required this.product}) : super(key: key);

  @override
  State<ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  double _opacityIcon = 0;
  @override
  void initState() {
    Future.delayed(
        const Duration(milliseconds: 100),
        () => setState(() {
              _opacityIcon = 1;
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacityIcon,
      duration: const Duration(seconds: 1),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Constants.secondaryColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            fixedSize: const Size(40, 40)),
        onPressed: () async {
          String linkURL = await Utils.createDynamicLink(
              context, 'Mira este producto!', widget.product);
          await Utils.share('Mira este producto!', '', linkURL, 'Compartir en');
        },
        child: const Icon(Icons.share, color: Colors.white, size: 22),
      ),
    );
  }
}
