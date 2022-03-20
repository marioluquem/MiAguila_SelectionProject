import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/products_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/utils.dart';

class AddToCartButton extends StatelessWidget {
  final ProductModel product;
  final Size size;
  const AddToCartButton(
      {Key? key, required this.product, this.size = const Size(50, 50)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Constants.secondaryColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10),
            fixedSize: size),
        onPressed: () {
          BlocProvider.of<ProductsCubit>(context).addProductToCart(product);
          //productsCubit.addProductToCart(product);
          Utils.showSnackBar(context: context, msg: "Added to cart");
        },
        child: Icon(
          Icons.add_shopping_cart_outlined,
          size: size.height / 2,
        ));
  }
}
