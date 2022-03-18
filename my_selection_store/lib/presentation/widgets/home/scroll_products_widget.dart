import 'package:flutter/material.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/helpers/utils.dart';
import 'package:my_selection_store/presentation/widgets/general/circular_container_widget.dart';

class ScrollProductsHome extends StatefulWidget {
  ScrollProductsHome({Key? key}) : super(key: key);

  @override
  State<ScrollProductsHome> createState() => _ScrollProductsHomeState();
}

class _ScrollProductsHomeState extends State<ScrollProductsHome> {
  List<ProductModel> listScrollProducts = [];

  @override
  void initState() {
    // TODO: cargar la listScrollProducts con await
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listProducts = getFeaturedProductsList();
    bool isPortrait = Utils.isOrientationPortrait(context);

    return Padding(
      padding: EdgeInsets.only(
          top: isPortrait ? MediaQuery.of(context).size.height * 0.2 : 0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 0.72,
            ),
            children: [...listProducts]),
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

  getFeaturedProductsList() {
    listScrollProducts = [
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

    List<Widget> listScrollWidgets = List.generate(listScrollProducts.length,
        (index) => buildIndividualProduct(listScrollProducts[index], index));

    return listScrollWidgets;
  }

  buildIndividualProduct(ProductModel product, int index) {
    final _widthCard = MediaQuery.of(context).size.width * 0.5 - 30;
    return Card(
      margin: const EdgeInsets.all(15),
      elevation: 8,
      child: Container(
        width: _widthCard,
        height: index % 2 == 0 ? 200 : 250,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.detailPath,
                    arguments: [product, "${index}Scroll"]);
              },
              child: CircularContainer(
                size: 120,
                child: Container(
                  color: Constants.mainColor,
                  child: Hero(
                    tag: "image${product.id}-${index}Scroll",
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
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Constants.secondaryColor,
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10)),
                          onPressed: () {
                            print(
                                "PRESIONO EN AGREGAR AL CARRITO"); //TODO AGREGAR AL CARRITO
                          },
                          child: const Icon(Icons.add_shopping_cart_outlined)),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
