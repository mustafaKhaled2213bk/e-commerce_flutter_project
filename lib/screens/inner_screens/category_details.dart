import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/services/category_service.dart';
import 'package:e_commerce/services/search_service.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class CategoryProducts extends StatefulWidget {
  final String categoryName;
  const CategoryProducts({super.key, required this.categoryName});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  bool isLoading = false;
  List<Product> products = [];
  late TextEditingController searchTextController;
  late List<Product> filteredProducts;
  late List<Product> productsToShow;
  @override
  void initState() {
    initProducts();
    productsToShow = products;
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TitlesTextWidget(label: widget.categoryName.toUpperCase()),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                ))),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      searchTextController.clear();
                      FocusScope.of(context).unfocus();
                      productsToShow = products;
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {},
                onSubmitted: (value) async {
                  filteredProducts = await SearchService.searchByCategory(
                      widget.categoryName, searchTextController.text);
                  productsToShow = filteredProducts;
                  if(mounted)
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              const SizedBox(
                height: 15.0,
              ),
              !isLoading
                  ? Expanded(
                      child: DynamicHeightGridView(
                        itemCount: productsToShow.length,
                        builder: ((context, index) {
                          return ProductWidget(
                            product: productsToShow[index],
                          );
                        }),
                        crossAxisCount: 2,
                      ),
                    )
                  : Expanded(
                      child: Center(
                          child: SizedBox(
                        height: 150,
                        width: 150,
                        child: LiquidCircularProgressIndicator(
                          value: 0.25, // Defaults to 0.5.
                          valueColor: const AlwaysStoppedAnimation(Colors
                              .pink), // Defaults to the current Theme's accentColor.
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                               // Defaults to the current Theme's backgroundColor.
                          borderColor: Colors.red,
                          borderWidth: 5.0,
                          direction: Axis.vertical,
                          // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                          center: const SubtitleTextWidget(label: "Loading..."),
                        ),
                      )),
                    ),
            ],
          ),
        ));
  }

  Future<void> initProducts() async {
    setState(() {
      isLoading = true;
    });
    products = await CategoryService.getCategoryProducts(widget.categoryName);
    productsToShow = products;
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
