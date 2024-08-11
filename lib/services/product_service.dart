import 'dart:convert';

import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/services/api.dart';

class ProductService {
  static Future<List<Product>?> getMostSellingProducts() async {
    List<Product>? products;
    final res = await Api.get('products', {
      'limit': '10',
    });
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        products = productResponse.products; //.getRange(0, 10).toList();
      }
    }
    return products;
  }

  ///
  /// This method is used to get all product
  /// [return] list of product objects
  /// [todo] add pagination to this method
  ///
  static Future<List<Product>?> getProducts() async {
    List<Product>? products;
    final res = await Api.get('products');
    if (res.statusCode == 200) {
      final productResponse = ProductsResponse.fromJson(jsonDecode(res.body));
      if (productResponse.products.isNotEmpty) {
        products = productResponse.products;
      }
    }
    return products;
  }

  static Future<Product> getProductById(int id) async {
    final res = await Api.get('products/$id');
    Product product = Product.fromJson(jsonDecode(res.body));
    return product;
  }
}
