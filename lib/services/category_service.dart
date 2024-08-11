import 'dart:convert';

import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/services/api.dart';

class CategoryService {
  static Future<List<Product>> getCategoryProducts(String categoryName) async {
    final res = await Api.get('products/category/$categoryName');
    if (res.statusCode == 200) {
      var productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      return productResponse.products;
    }
    return [];
  }
}