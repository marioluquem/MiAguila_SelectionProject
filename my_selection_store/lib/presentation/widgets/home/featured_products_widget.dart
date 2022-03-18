import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_selection_store/data/models/product_model.dart';
import 'package:my_selection_store/helpers/constants.dart';
import 'package:my_selection_store/helpers/routes.dart';
import 'package:my_selection_store/presentation/widgets/general/circular_container_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FeaturedProductsHome extends StatefulWidget {
  const FeaturedProductsHome({Key? key}) : super(key: key);

  @override
  State<FeaturedProductsHome> createState() => _FeaturedProductsHomeState();
}

class _FeaturedProductsHomeState extends State<FeaturedProductsHome> {
  final CarouselController carouselController = CarouselController();
  int indexCarouselFeatured = 0;
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
          featuredTitle(),
          carouselProducts(context, listFeatured),
          dots(listFeatured)
        ],
      ),
    );
  }

  AnimatedSmoothIndicator dots(List<Widget> listFeatured) {
    return AnimatedSmoothIndicator(
      effect: WormEffect(
          activeDotColor: Constants.secondaryColorLight,
          dotColor: Constants.secondaryColor.withOpacity(0.5)),
      activeIndex: indexCarouselFeatured,
      count: listFeatured.length,
      onDotClicked: (index) {
        indexCarouselFeatured = index;
        carouselController.animateToPage(index);
        print(index);
      },
    );
  }

  Stack carouselProducts(BuildContext context, List<Widget> listFeatured) {
    return Stack(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              height: 70,
              onPageChanged: (index, reason) {
                setState(() {
                  indexCarouselFeatured = index;
                });
              }),
          items: listFeatured,
          carouselController: carouselController,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                carouselController.previousPage();
              },
              icon: const Icon(Icons.arrow_back_ios,
                  size: 30, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                carouselController.nextPage();
              },
              icon: const Icon(Icons.arrow_forward_ios,
                  size: 30, color: Colors.white),
            ),
          ],
        ),
      ),
    ]);
  }

  Text featuredTitle() {
    return Text(
      'Destacados',
      style: Constants.styleTitle(textColor: Colors.white),
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
    listFeaturedProducts = [
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
      ProductModel.fromJson(getInfo()),
    ];

    List<Widget> listFeatured =
        List.generate(listFeaturedProducts.length, (index) {
      final product = listFeaturedProducts[index];
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, MyRoutes.detailPath,
              arguments: [product, "${index}Featured"]);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularContainer(
              size: 75,
              child: Container(
                color: Constants.secondaryColor,
                child: Hero(
                  tag: "image${product.id}-${index}Featured",
                  child: FadeInImage(
                    placeholder: AssetImage(Constants.noImagePath),
                    image: NetworkImage(product.image),
                  ),
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
                        color: Constants.secondaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });

    return listFeatured;
  }
}
