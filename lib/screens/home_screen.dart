import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/consts/app_constants.dart';
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/screens/inner_screens/category_details.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:e_commerce/widgets/products/ctg_rounded_widget.dart';
import 'package:e_commerce/widgets/products/latest_arrival.dart';
import 'package:e_commerce/widgets/title_text.dart';
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> latestArrival;
  bool isLoading = true;
  @override
  void initState() {
    initProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        // backgroundColor: ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: ClipRRect(
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        AppConstants.bannersImages[index],
                        fit: BoxFit.fill,
                      );
                    },
                    loop: true,
                    autoplay: true,
                    itemCount: AppConstants.bannersImages.length,
                    pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitlesTextWidget(
                label: "Recommended For you",
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: !isLoading
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: latestArrival.length,
                        itemBuilder: (context, index) {
                          return LatestArrivalProductsWidget(
                            product: latestArrival[index],
                          );
                        })
                    : const Center(child: CircularProgressIndicator()),
              ),
              const SizedBox(
                height: 18,
              ),
              const TitlesTextWidget(
                label: "Categories",
                fontSize: 22,
              ),
              const SizedBox(
                height: 18,
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  children: List.generate(AppConstants.categoriesList.length,
                      (index) {
                    return InkWell(
                      child: FittedBox(
                        // fit: BoxFit.fill,
                        // clipBehavior: Clip.antiAlias,
                        child: CategoryRoundedWidget(
                          image: AppConstants.categoriesList[index].image,
                          name: AppConstants.categoriesList[index].name,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return CategoryProducts(
                              categoryName:
                                  AppConstants.categoriesList[index].id);
                        }));
                      },
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initProducts() async {
    setState(() {
      isLoading = true;
    });
    latestArrival = (await ProductService.getMostSellingProducts()) ?? [];
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
