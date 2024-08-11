import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/screens/auth/login.dart';
import 'package:e_commerce/screens/inner_screens/product_details.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () async {
          // await Navigator.pushNamed(context, ProductDetails.routName);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductDetails(
                    product: widget.product,
                  )));
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: FancyShimmerImage(
                boxFit: BoxFit.contain,
                imageUrl: widget.product.thumbnail,
                width: double.infinity,
                height: size.height * 0.22,
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TitlesTextWidget(label: widget.product.title),
                ),
                Flexible(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(IconlyLight.heart),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: SubtitleTextWidget(
                      label: widget.product.price.toStringAsFixed(2)),
                ),
                Flexible(
                  child: Material(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.lightBlue,
                      child: Consumer<CartNotefier>(
                        builder: (context, cartProvider, child) {
                          return Consumer<LoginNotifier>(
                            builder: (context, value, child) {
                              return InkWell(
                                splashColor: Colors.red,
                                borderRadius: BorderRadius.circular(16.0),
                                onTap: () {
                                  if (value.isLoggedIn) {
                                    cartProvider.addProduct(widget.product);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('you cannot add to cart'),
                                      action: SnackBarAction(
                                        label: 'Login',
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return LoginScreen();
                                            },
                                          ));
                                        },
                                      ),
                                    ));
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.add_shopping_cart_rounded),
                                ),
                              );
                            },
                          );
                        },
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
