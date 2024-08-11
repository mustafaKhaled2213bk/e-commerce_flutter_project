import 'package:e_commerce/models/products_response.dart';
import 'package:flutter/cupertino.dart';

class CartNotefier extends ChangeNotifier {
  Map<Product, int> products = {};

  void addProduct(Product product) {
    if (products.containsKey(product)) {
      products[product] = products[product]! + 1;
    } else {
      products[product] = 1;
    }
    notifyListeners();
  }

  void removeProduct(Product product) {
    if (products[product]! > 1) {
      products[product] = products[product]! - 1;
    } else {
      products.remove(product);
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int newQuantity) {
    products[product] = newQuantity;
    notifyListeners();
  }

  void clearCart() {
    products.clear();
    notifyListeners();
  }
}
