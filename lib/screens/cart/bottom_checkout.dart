import 'dart:developer';

import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/providers/order_notifier.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/services/db_service.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartNotefier>(context);
    final orderProvider = Provider.of<OrderNotifier>(context);
    var totalPrice = 0.0;
    cartProvider.products.forEach(
      (key, value) {
        totalPrice += key.price * value;
      },
    );
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitlesTextWidget(
                        label:
                            "Total (${cartProvider.products.length} products/${(
                          cartProvider.products.values.toList().fold(
                              0,
                              (previousValue, element) =>
                                  previousValue + element),
                        )} Items)",
                      ),
                    ),
                    SubtitleTextWidget(
                      label: totalPrice.toStringAsFixed(2),
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AssetsManager.pay,
                                height: 60,
                                width: 60,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              const SubtitleTextWidget(
                                label: "Confirm ",
                                fontWeight: FontWeight.w600,
                              ),
                              Text(
                                  "Are you sure to pay ${totalPrice.toStringAsFixed(2)} to complete your purchase ?"),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const SubtitleTextWidget(
                                        label: "Cancel", color: Colors.green),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      //TODO: add to orders table...

                                      List<int> productsIds = [];
                                      for (var product
                                          in cartProvider.products.keys) {
                                        productsIds.add(product.id);
                                      }

                                      // DatabaseService.
                                      Database db =
                                          await DatabaseService().database;
                                      await db.insert(
                                          'orders',
                                          Order(
                                                  date: DateTime.now(),
                                                  productsIDs: productsIds)
                                              .toMap());

                                      var or =
                                          await DatabaseService.getAllOrders();
                                      orderProvider.addOrder(Order(
                                          date: DateTime.now(),
                                          productsIDs: productsIds));
                                      cartProvider.clearCart();
                                      Navigator.pop(context);
                                    },
                                    child: const SubtitleTextWidget(
                                        label: "OK", color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: const Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
