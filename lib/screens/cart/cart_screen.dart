import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/screens/cart/bottom_checkout.dart';
import 'package:e_commerce/screens/cart/cart_widget.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/widgets/empty_bag.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  Provider<CartNotefier>(create: (context) => ,);
    final cartProvider = Provider.of<CartNotefier>(context);

    var products = cartProvider.products.keys.toList();
    return products.isEmpty
        ? Scaffold(
            body: EmptyBagWidget(
              imagePath: AssetsManager.shoppingBasket,
              title: "Your cart is empty",
              subtitle:
                  'Looks like you didn\'t add anything yet to your cart \ngo ahead and start shopping now',
              buttonText: "Shop Now",
            ),
          )
        : Scaffold(
            bottomSheet: const CartBottomCheckout(),
            appBar: AppBar(
              title: TitlesTextWidget(
                  label: "Cart ${cartProvider.products.length}"),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AssetsManager.shoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    cartProvider.clearCart();
                  },
                  icon: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: cartProvider.products.length,
              itemBuilder: (context, index) {
                return CartWidget(
                  product: products[index],
                  quantity: cartProvider.products[products[index]]!,
                );
              },
            ),
          );
  }
}
