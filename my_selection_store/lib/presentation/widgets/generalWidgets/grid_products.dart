import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/helpers/utils.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/add_to_cart_button.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/circular_container_widget.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/remove_button.dart';

class GridProducts extends StatefulWidget {
  final bool isLoading;
  List<ProductModel> listProducts;
  final bool showAddToCart;
  final bool showDeleteFromCart;
  String heroIdentifier;
  final bool animate;

  GridProducts({
    Key? key,
    required this.isLoading,
    required this.listProducts,
    required this.showAddToCart,
    required this.showDeleteFromCart,
    required this.heroIdentifier,
    this.animate = true,
  }) : super(key: key);

  @override
  State<GridProducts> createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts>
    with TickerProviderStateMixin {
  late ProductsCubit productsCubit;
  bool deletedAProduct = false;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
        childAspectRatio: 0.72,
      ),
      children: widget.isLoading
          ? buildLoadingList()
          : buildProductsListWidgets(
              context: context, listProductsModels: widget.listProducts),
    );
  }

  List<Widget> buildLoadingList() {
    return List.generate(10,
        (index) => const Center(child: CircularProgressIndicator.adaptive()));
  }

  List<Widget> buildProductsListWidgets(
      {required context, required listProductsModels}) {
    List<Widget> listScrollWidgets = List.generate(
        listProductsModels.length,
        (index) =>
            buildIndividualProduct(context, listProductsModels[index], index));

    return listScrollWidgets;
  }

  buildIndividualProduct(
      BuildContext context, ProductModel product, int index) {
    final _widthCard = MediaQuery.of(context).size.width * 0.5 - 30;
    AnimationController controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        vsync: this,
        value: widget.animate ? 0.1 : 1);
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.ease);

    if (widget.animate && !deletedAProduct) {
      controller.forward();
    }
    return ScaleTransition(
      scale: animation,
      child: Card(
        margin: const EdgeInsets.all(15),
        elevation: 8,
        child: Container(
          width: _widthCard,
          height: index % 2 == 0 ? 200 : 250,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(children: [
                productInfo(context, product, index),
                removeButton(controller, context, index),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Column productInfo(BuildContext context, ProductModel product, int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.detailPath,
                arguments: [product, "$index-${widget.heroIdentifier}"]);
          },
          child: Hero(
            tag: "image${product.id}-$index-${widget.heroIdentifier}",
            child: CircularContainer(
              size: 120,
              child: Container(
                color: Constants.mainColor,
                child: FadeInImage(
                  placeholder: AssetImage(Constants.noImagePath),
                  image: NetworkImage(product.image),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.detailPath,
                    arguments: [product, "${index}Scroll"]);
              },
              child: Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${product.price.toString()}",
                  style: TextStyle(
                      color: Constants.pricesColor,
                      fontWeight: FontWeight.bold),
                ),
                Transform.translate(
                  offset: const Offset(25, 0),
                  child: widget.showAddToCart
                      ? AddToCartButton(product: product)
                      : Container(),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget removeButton(
      AnimationController controller, BuildContext context, int index) {
    return widget.showDeleteFromCart
        ? Positioned(
            top: -10,
            right: -5,
            child: RemoveButton(
                size: 35,
                onPressed: () async {
                  deletedAProduct =
                      true; //bool para evitar que haga animación de entrada del ultimo producto después de eliminar
                  controller.reverse(); //hacemos animacion de dismiss
                  await Future.delayed(const Duration(seconds: 1));

                  productsCubit.removeProductFromCart(index);
                  Utils.showSnackBar(
                      context: context, msg: "Removed from cart");
                  await Future.delayed(const Duration(milliseconds: 200));
                  deletedAProduct = false;
                }),
          )
        : Container();
  }
}