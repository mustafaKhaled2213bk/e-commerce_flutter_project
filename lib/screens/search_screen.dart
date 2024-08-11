import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/services/search_service.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import '../services/assets_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  late TextEditingController searchTextController;
  List<Product> searchResult = [];

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const TitlesTextWidget(label: "Search"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        searchTextController.clear();
                        FocusScope.of(context).unfocus();
                        setState(() {
                          searchResult = [];
                        });
                      },
                      child: const Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onChanged: (value) {},
                  onSubmitted: (value) async {
                    await getSearchResult();
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Expanded(
                  child: searchResult.isEmpty && !isLoading
                      ? const Center(child: Text('Type anything....'))
                      : isLoading
                          ? Expanded(
                              child: Center(
                                  child: SizedBox(
                                height: 150,
                                width: 150,
                                child: LiquidCircularProgressIndicator(
                                  value: 0.25, // Defaults to 0.5.
                                  valueColor: const AlwaysStoppedAnimation(Colors
                                      .pink), // Defaults to the current Theme's accentColor.
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  // Defaults to the current Theme's backgroundColor.
                                  borderColor: Colors.red,
                                  borderWidth: 5.0,
                                  direction: Axis.vertical,
                                  // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                                  center: const SubtitleTextWidget(
                                      label: "Loading..."),
                                ),
                              )),
                            )
                          : DynamicHeightGridView(
                              itemCount: searchResult.length,
                              builder: ((context, index) {
                                return ProductWidget(
                                  product: searchResult[index],
                                );
                              }),
                              crossAxisCount: 2,
                            ),
                  //
                ),
              ],
            ),
          )),
    );
  }

  Future<void> getSearchResult() async {
    setState(() {
      isLoading = true;
    });
    var result = await SearchService.search(searchTextController.text);
    await Future.delayed(const Duration(seconds: 1));

    searchResult = result;
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
}
