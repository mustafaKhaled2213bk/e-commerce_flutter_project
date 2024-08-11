import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late List<Product> products = [];
  bool isloading = false;
  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: isloading
            ? Center(
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
                  center: const SubtitleTextWidget(label: "Loading..."),
                ),
              ))
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    
                    const TitlesTextWidget(
                      label: 'Products',
                      color: Colors.purple,
                    ),
                    AspectRatio(
                      aspectRatio: 0.75,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return ProductWidget(product: products[index]);
                        },
                        itemCount: products.length,
                      ),
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.white,
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TitlesTextWidget(label: 'Total Price : '),
                        TitlesTextWidget(
                          label: totalPrice().toStringAsFixed(2) + "\$",
                          color: Colors.blue,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TitlesTextWidget(label: 'Ordered At:'),
                        SubtitleTextWidget(
                          label: DateFormat('dd/MM/yyyy')
                              .format(widget.order.date),
                          color: Colors.blue,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Consumer<CartNotefier>(
                          builder: (context, value, child) {
                            return ElevatedButton.icon(
                              icon: Icon(Icons.add_shopping_cart),
                              onPressed: () {
                                for (Product p in products) {
                                  value.addProduct(p);
                                }
                              },
                              label: Text('Order Again'),
                            );
                          },
                        ))
                  ],
                ),
              ));
  }

  Future<void> init() async {
    // var productsList = <Product>[];
    // ProductService.getProductById(id)
    setState(() {
      isloading = true;
    });
    for (int id in widget.order.productsIDs) {
      products.add(await ProductService.getProductById(id));
    }
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }

  double totalPrice() {
    var sum = 0.0;
    for (Product p in products) {
      sum += p.price;
    }
    return sum;
  }
}
