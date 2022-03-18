import 'package:flutter/material.dart';
import 'package:my_selection_store/data/models/product_model.dart';

class DetailScreen extends StatelessWidget {
  final ProductModel product;
  final String idHero;
  const DetailScreen({Key? key, required this.product, required this.idHero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Hero(
                tag: "image${product.id}-$idHero",
                child: Image.network(
                  product.image,
                  height: MediaQuery.of(context).size.height * 0.4,
                )),
            Text(product.title)
          ],
        ),
      ),
    );
  }
}
