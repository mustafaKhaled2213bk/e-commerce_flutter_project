import 'dart:convert';

import 'package:e_commerce/models/products_response.dart';
import 'package:e_commerce/services/api.dart';

class SearchService {
  static Future<List<Product>> search(String searchTxt) async {
    var res = await Api.get('products/search', {'q': searchTxt});
    var productRes = ProductsResponse.fromJson(jsonDecode(res.body));
    return productRes.products;
  }

  static Future<List<Product>> searchByCategory(
      String categoryName, String searchTxt) async {
    List<Product> result = <Product>[];
    final searchResult = await search(searchTxt);
    for (var p in searchResult) {
      if (p.category == categoryName) {
        result.add(p);
      }
    }
    return result;
  }
}
