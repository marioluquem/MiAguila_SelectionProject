import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/internet_cubit.dart';
import '../../../business_logic/cubit/products_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/enums.dart';
import '../../../helpers/routes.dart';
import '../../../helpers/utils.dart';
import '../generalWidgets/circular_container_widget.dart';
import '../generalWidgets/remove_button.dart';

class QuickCartView extends StatefulWidget {
  final bool heroActive;
  final bool
      useMaxWidth; //Para usar el maxWidth del screen (en el Home se tiene un botón a la derecha por lo que no usa el maxWidth, en Detalle si)
  const QuickCartView(
      {Key? key, this.heroActive = true, this.useMaxWidth = true})
      : super(key: key);

  @override
  State<QuickCartView> createState() => _QuickCartViewState();
}

class _QuickCartViewState extends State<QuickCartView>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  bool deletedAProduct = false; //bool para controlar IN or OUT animation

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 15),
      decoration: BoxDecoration(color: Colors.grey.shade100, boxShadow: const [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 5,
            spreadRadius: 1)
      ]),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(minHeight: 50),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width *
                (widget.useMaxWidth ? 0.96 : 0.76),
            child: BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {},
              builder: (context, state) {
                //Si está cargando los productos, mostramos varios loading simulando los productos
                if (state.listProductsHandlersStates
                    .contains(EnumProductsLoadingState.loadingCart)) {
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
                    //para actualizar el scroll de los productos del carrito a la ultima posición al agregar
                    Utils.scrollToMaxLength(scrollController);

                    return ListView(
                      controller: scrollController,
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
                      style: TextStyle(color: Colors.black87, fontSize: 12),
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

    Widget heroContent = Builder(builder: (context) {
      bool hasConnection =
          context.watch<InternetCubit>().isConnectedToInternet();
      return CircularContainer(
        size: 45,
        aspectRatio: 1,
        backgroundColor: Constants.mainColor,
        child: hasConnection
            ? FadeInImage(
                placeholder: AssetImage(Constants.noImagePath),
                image: NetworkImage(product.image))
            : Image.asset(Constants.noImagePath),
      );
    });

    Widget content = Stack(alignment: Alignment.topCenter, children: [
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
                Utils.showSnackBar(context: context, msg: "Removed from cart");
                await Future.delayed(const Duration(milliseconds: 200));
                deletedAProduct = false;
              }))
    ]);

    //si es el ultimo producto, se le hace la animación de entrada
    if (index == listProducts.length - 1) {
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
