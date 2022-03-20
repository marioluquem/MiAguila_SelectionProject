import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/cubit/products_cubit.dart';
import '../../../data/models/product_model.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/enums.dart';
import '../../../helpers/routes.dart';
import '../generalWidgets/circular_container_widget.dart';
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
  late ProductsCubit productsCubit;

  @override
  void initState() {
    productsCubit = BlocProvider.of<ProductsCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      decoration: BoxDecoration(
          color: Constants.mainColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100))),
      height: MediaQuery.of(context).size.height * 0.15,
      constraints: const BoxConstraints(minHeight: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [featuredTitle(), carouselProducts(context), dots()],
      ),
    );
  }

  Widget dots() {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return AnimatedSmoothIndicator(
          effect: WormEffect(
              activeDotColor: Constants.secondaryColorLight,
              dotColor: Constants.secondaryColor.withOpacity(0.5)),
          activeIndex: indexCarouselFeatured,
          count: state.listFeaturedProducts.length,
          onDotClicked: (index) {
            indexCarouselFeatured = index;
            carouselController.animateToPage(index);
            print(index);
          },
        );
      },
    );
  }

  Widget carouselProducts(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: state.listProductsHandlersStates
                    .contains(EnumProductsLoadingState.loadingFeatured)
                ? const Center(child: CircularProgressIndicator.adaptive())
                : CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 4),
                        height: 70,
                        onPageChanged: (index, reason) {
                          setState(() {
                            indexCarouselFeatured = index;
                          });
                        }),
                    items: getFeaturedProductsList(state.listFeaturedProducts),
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
      },
    );
  }

  Text featuredTitle() {
    return Text(
      'Destacados',
      style: Constants.styleTitle(textColor: Colors.white),
    );
  }

  getFeaturedProductsList(List<ProductModel> listFeaturedProductsModels) {
    return List.generate(listFeaturedProductsModels.length, (index) {
      final product = listFeaturedProductsModels[index];
      return GestureDetector(
        onTap: () {
          productsCubit.setDetailProduct(product);
          Navigator.pushNamed(context, MyRoutes.detailPath,
              arguments: ["${index}Featured"]);
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
  }
}
