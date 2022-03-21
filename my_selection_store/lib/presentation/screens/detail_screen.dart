import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/dynamiclinks_cubit.dart';
import '../../business_logic/cubit/internet_cubit.dart';
import '../../business_logic/cubit/products_cubit.dart';
import '../../data/models/product_model.dart';
import '../../helpers/constants.dart';
import '../../helpers/utils.dart';
import '../widgets/generalWidgets/add_to_cart_button.dart';
import '../widgets/homeWidgets/quick_view_cart_widget.dart';

class DetailScreen extends StatefulWidget {
  final String idHero;
  const DetailScreen({Key? key, required this.idHero}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late ProductsCubit productsCubit;
  late ProductModel product;
  late DynamiclinksCubit dynamiclinksCubit;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    dynamiclinksCubit = BlocProvider.of<DynamiclinksCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = Utils.isOrientationPortrait(context);
    product = productsCubit.state.selectedDetailProduct;

    //reading possible dynamiclinks
    dynamiclinksCubit.checkForDynamicLinksReceived(context);

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

  buildProductImage(BuildContext context, bool isPortrait) {
    return Builder(builder: (context) {
      bool hasConnection =
          context.watch<InternetCubit>().isConnectedToInternet();
      return Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight:
              MediaQuery.of(context).size.height * (isPortrait ? 0.4 : 0.3),
        ),
        decoration:
            BoxDecoration(color: Constants.secondaryColor, boxShadow: const [
          BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 5),
              blurRadius: 5,
              spreadRadius: 1)
        ]),
        child: Hero(
          tag: "image${product.id}-${widget.idHero}",
          child: hasConnection
              ? Image.network(product.image)
              : Image.asset(Constants.noImagePath),
        ),
      );
    });
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
