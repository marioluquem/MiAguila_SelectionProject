import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_selection_store/business_logic/cubit/products_cubit.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/helpers/utils.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/circular_container_widget.dart';
import 'package:my_selection_store/presentation/widgets/generalWidgets/remove_button.dart';

class QuickCartView extends StatefulWidget {
  final bool heroActive;
  const QuickCartView({Key? key, this.heroActive = true}) : super(key: key);

  @override
  State<QuickCartView> createState() => _QuickCartViewState();
}

class _QuickCartViewState extends State<QuickCartView>
    with TickerProviderStateMixin {
  bool deletedAProduct = false; //bool para controlar IN or OUT animation

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 15),
      decoration: BoxDecoration(
        color: Constants.mainColor,
      ),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(minHeight: 50),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.76,
            child: BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {},
              builder: (context, state) {
                //Si está cargando los productos, mostramos varios loading simulando los productos
                if (state.listProductsHandlersStates
                    .contains(ProductsHandlerState.loadingCart)) {
                  return Row(
                    children: List.generate(
                      5,
                      (index) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  );
                } else {
                  //Si tiene productos en carrito, los muestra, sino muestra un texto
                  if (state.listCartProducts.isNotEmpty) {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        ...buildMiniProducts(context, state.listCartProducts),
                        const SizedBox(
                          width: 20,
                        )
                      ],
                    );
                  } else {
                    return const Text(
                      'Your cart is empty. Try adding some products!',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildMiniProducts(
      BuildContext context, List<ProductModel> listCartProducts) {
    return List.generate(
        listCartProducts.length,
        (index) =>
            buildMiniProductIndividual(context, listCartProducts, index));
  }

  buildMiniProductIndividual(
      BuildContext context, List<ProductModel> listProducts, int index) {
    ProductModel product = listProducts[index];

    //configuramos la animación
    AnimationController controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
      value: deletedAProduct
          ? 1
          : 0.1, //solo hace la animación de entrada si agregó un producto (no si borró el ultimo)
    );
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.ease);

    Widget heroContent = CircularContainer(
      size: 45,
      aspectRatio: 1,
      backgroundColor: Constants.mainColor,
      child: FadeInImage(
        placeholder: AssetImage(Constants.noImagePath),
        image: NetworkImage(product.image),
      ),
    );

    Widget content = GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, MyRoutes.detailPath,
        //     arguments: [product, "$index-${Constants.heroCartIdentifier}"]);
      },
      child: Stack(alignment: Alignment.topCenter, children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: widget.heroActive
                ? Hero(
                    tag:
                        "image${product.id}-$index-${Constants.heroCartIdentifier}",
                    child: heroContent)
                : heroContent),
        Positioned(
            top: -15,
            right: -15,
            child: RemoveButton(
                size: 22,
                onPressed: () async {
                  deletedAProduct =
                      true; //bool para evitar que haga animación de entrada del ultimo producto después de eliminar
                  controller.reverse(); //hacemos animacion de dismiss
                  await Future.delayed(const Duration(seconds: 1));

                  ProductsCubit productsCubit =
                      BlocProvider.of<ProductsCubit>(context);
                  productsCubit.removeProductFromCart(index);
                  Utils.showSnackBar(
                      context: context, msg: "Removed from cart");
                  await Future.delayed(const Duration(milliseconds: 200));
                  deletedAProduct = false;
                }))
      ]),
    );

    //si es el ultimo producto, se le hace la animación de entrada
    if (index == listProducts.length - 1) {
      print("eNTRO A HACER LA ANIMACION");
      controller.forward();
      //se asigna la transicion
      content = ScaleTransition(
        scale: animation,
        child: content,
      );
    }

    return content;
  }
}
