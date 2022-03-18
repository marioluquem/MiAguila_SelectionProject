import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedProductsHome extends StatefulWidget {
  const FeaturedProductsHome({Key? key}) : super(key: key);

  @override
  State<FeaturedProductsHome> createState() => _FeaturedProductsHomeState();
}

class _FeaturedProductsHomeState extends State<FeaturedProductsHome> {
  final CarouselController _carouselController = CarouselController();
  int _indexCarouselFeatured = 0;
  List<ProductModel> listFeaturedProducts = [];

  @override
  void initState() {
    //TODO.leer desde aqui el API para definir los destacados y setearlos en  List<ProductModel> listFeaturedProducts
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listFeatured = getFeaturedProductsList();
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          color: Constants.mainColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100))),
      height: MediaQuery.of(context).size.height * 0.2,
      constraints: const BoxConstraints(minHeight: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Destacados',
            style: Constants.styleTitle(textColor: Colors.white),
          ),
          Stack(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                    height: 70,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _indexCarouselFeatured = index;
                      });
                    }),
                items: listFeatured,
                carouselController: _carouselController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _carouselController.previousPage();
                    },
                    icon: const Icon(Icons.arrow_back_ios,
                        size: 30, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      _carouselController.nextPage();
                    },
                    icon: const Icon(Icons.arrow_forward_ios,
                        size: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
          ]),
          AnimatedSmoothIndicator(
            activeIndex: _indexCarouselFeatured,
            count: listFeatured.length,
            onDotClicked: (index) {
              _indexCarouselFeatured = index;
              _carouselController.animateToPage(index);
              print(index);
            },
          )
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

  getFeaturedProductsList() {
    List<Widget> listFeatured = [];
    listFeaturedProducts = [
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
    ];

    for (var i = 0; i < listFeaturedProducts.length; i++) {
      final product = listFeaturedProducts[i];
      listFeatured.add(
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, MyRoutes.detailPath,
                arguments: [product, "${i}Featured"]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: "image${product.id}-${i}FeaturedDetail",
                  child: FadeInImage(
                    height: 80,
                    placeholder: AssetImage(Constants.noImagePath),
                    image: NetworkImage(product.image),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "\$${product.price.toString()}",
                      style: TextStyle(
                          color: Constants.pricesColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }

    return listFeatured;
  }
}
