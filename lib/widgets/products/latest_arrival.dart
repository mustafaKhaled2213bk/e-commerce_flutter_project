import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/screens/auth/login.dart';
import 'package:e_commerce/screens/inner_screens/product_details.dart';
import 'package:e_commerce/widgets/heart_btn.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  final Product product;
  const LatestArrivalProductsWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          // await Navigator.pushNamed(context, ProductDetails.routName);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => ProductDetails(product: product)));
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: product.thumbnail,
                    width: size.width * 0.28,
                    height: size.width * 0.28,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          const HeartButtonWidget(),
                          Consumer<CartNotefier>(
                            builder: (context, cartProvider, child) {
                              return Consumer<LoginNotifier>(
                                builder: (context, value, child) {
                                  return IconButton(
                                onPressed: () {
                                  if (value.isLoggedIn) {
                                  cartProvider.addProduct(product);
                                    
                                  }else{
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
                                  // print(value.products.keys.toList());
                                },
                                icon: const Icon(
                                  Icons.add_shopping_cart_rounded,
                                  size: 18,
                                ),
                              );
                                },
                              );
                            },
                          )
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubtitleTextWidget(
                        label: product.price.toStringAsFixed(2),
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
