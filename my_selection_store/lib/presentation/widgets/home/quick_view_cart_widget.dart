import 'package:flutter/material.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/presentation/widgets/general/circular_container_widget.dart';

class QuickCartView extends StatelessWidget {
  late List<ProductModel> listCartProducts;
  QuickCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10, left: 15),
      decoration: BoxDecoration(
        color: Constants.secondaryColor,
      ),
      // borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(100), topRight: Radius.circular(100))),
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(minHeight: 50),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.76,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                ...buildMiniProducts(context),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  getInfo() {
    return {
      "id": 1,
      "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
      "price": 109.95,
      "description":
          "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
      "category": "men's clothing",
      "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
      "rating": {"rate": 3.9, "count": 120}
    };
  }

  List<Widget> buildMiniProducts(BuildContext context) {
    listCartProducts = [
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
    ];

    return List.generate(
        listCartProducts.length,
        (index) => buildMiniProductIndividual(
            context, listCartProducts[index], index));
  }

  buildMiniProductIndividual(
      BuildContext context, ProductModel product, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.detailPath,
            arguments: [product, "${index}QuickCart"]);
      },
      child: Hero(
        tag: "image${product.id}-${index}QuickCart",
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: CircularContainer(
            size: 45,
            aspectRatio: 1,
            backgroundColor: Constants.mainColor,
            child: FadeInImage(
              placeholder: AssetImage(Constants.noImagePath),
              image: NetworkImage(product.image),
            ),
          ),
        ),
      ),
    );
  }

  // buildShoppingCardButton(BuildContext context) {
  //   return Transform.scale(
  //     scale: 1.2,
  //     child: FloatingActionButton(
  //       backgroundColor: Constants.secondaryColor,
  //       onPressed: () {
  //         Navigator.pushNamed(context, MyRoutes.myCartPath);
  //       },
  //       child: const Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Icon(
  //           Icons.shopping_cart,
  //           color: Colors.white,
  //           size: 30,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
