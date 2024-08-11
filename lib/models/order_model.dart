import 'dart:convert';

import 'package:e_commerce/models/order_product_model.dart';
import 'package:e_commerce/models/products_response.dart';

class Order {
  int? id;
  DateTime date;
  List<int> productsIDs;

  Order({this.id, required this.date, required this.productsIDs});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'productsIDs': jsonEncode(productsIDs), // تحويل المصفوفة إلى JSON
    };
  }
}