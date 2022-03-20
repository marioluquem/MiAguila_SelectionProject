import 'package:flutter/material.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/utils.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/add_to_cart_button.dart';
import 'package:my_selection_store/presentation/widgets/homeWidgets/quick_view_cart_widget.dart';

class DetailScreen extends StatelessWidget {
  final ProductModel product;
  final String idHero;
  const DetailScreen({Key? key, required this.product, required this.idHero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.isOrientationPortrait(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(children: [
                buildProductImage(context, isPortrait),
                buildBackArrow(context),
              ]),
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.475,
                    minHeight: 50),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomScrollView(slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        buildTitleCategoryStarsPrice(context),
                        const SizedBox(
                          height: 12,
                        ),
                        buildDescription(),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildStock(),
                            buildAddToCartButton(),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              buildQuickCartView(),
            ]),
      ),
    );
  }

  Container buildProductImage(BuildContext context, bool isPortrait) {
    return Container(
      color: Constants.secondaryColor,
      width: double.infinity,
      child: Hero(
          tag: "image${product.id}-$idHero",
          child: Image.network(
            product.image,
            height:
                MediaQuery.of(context).size.height * (isPortrait ? 0.4 : 0.3),
          )),
    );
  }

  Padding buildBackArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 20),
      child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:
              const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30)),
    );
  }

  Row buildTitleCategoryStarsPrice(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.55,
              child: Text(
                product.title,
                style: Constants.styleTitle(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.category,
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(
              height: 12,
            ),
            buildStars(),
          ],
        ),
        Text(
          "\$${product.price}",
          style: TextStyle(color: Constants.pricesColor, fontSize: 28),
        ),
      ],
    );
  }

  buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (index) {
        if (product.rating.rate > index) {
          return const Icon(
            Icons.star,
            color: Colors.amber,
            size: 34,
          );
        } else {
          return const Icon(
            Icons.star_border,
            color: Colors.amber,
            size: 34,
          );
        }
      }),
    );
  }

  Text buildDescription() {
    return Text(
      product.description,
      style: const TextStyle(color: Colors.black54, fontSize: 16),
      textAlign: TextAlign.justify,
    );
  }

  Row buildStock() {
    return Row(
      children: [
        const Text(
          "Stock available:",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          "${product.rating.count}",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }

  Widget buildQuickCartView() {
    return Column(
      children: const [
        // SizedBox(
        //   height: 12,
        // ),
        QuickCartView(
          heroActive: false,
        ),
      ],
    );
  }

  buildAddToCartButton() {
    return AddToCartButton(
      product: product,
      size: const Size(65, 65),
    );
  }
}
