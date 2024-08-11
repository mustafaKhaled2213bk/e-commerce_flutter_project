
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/providers/cart_notifier.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  final Product product;
  const QuantityBottomSheetWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: Consumer<CartNotefier>(
            builder: (context, value, child) {
              return ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        value.updateQuantity(product, index + 1);
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: SubtitleTextWidget(
                            label: "${index + 1}",
                          ),
                        ),
                      ),
                    );
                  });
            },
          )),
        ],
      ),
    );
  }
}
