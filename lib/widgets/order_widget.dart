import 'dart:developer';

import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/screens/inner_screens/order_details_screen.dart';
import 'package:e_commerce/services/assets_manager.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:e_commerce/widgets/custom_list_tile.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  OrderWidget({super.key, required this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late Product product;
  bool isloading = true;
  @override
  void initState() {
    initProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11))),
      leading: Image.asset(
        AssetsManager.orderSvg,
        width: 42,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitlesTextWidget(
            label: DateFormat('dd/MM/yyyy').format(widget.order.date),
          ),
          SubtitleTextWidget(
              label: "${widget.order.date.hour}:${widget.order.date.minute}")
        ],
      ),
      subtitle: isloading
          ? Container()
          : SubtitleTextWidget(
              fontSize: 16,
              label: '${product.title}....',
            ),
      // subtitle: ,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return OrderDetailsScreen(order: widget.order);
        }));
      },
    );
  }

  initProduct() async {
    setState(() {
      isloading = true;
    });

    product = await ProductService.getProductById(widget.order.productsIDs[0]);
    if (mounted) {
      setState(() {
        isloading = false;
      });
    }
  }
}
