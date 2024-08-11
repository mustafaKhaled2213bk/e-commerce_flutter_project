import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/services/db_service.dart';
import 'package:flutter/material.dart';

class OrderNotifier extends ChangeNotifier {
  List<Order> orders = [];
  OrderNotifier() {
    getOrders();
  }
  addOrder(Order newOrder) {
    orders.add(newOrder);
    notifyListeners();
  }

  getOrders() async {
    // final db= DatabaseService.in;
    //  Database db =await DatabaseService().database;
    orders = await DatabaseService.getAllOrders();
    notifyListeners();
  }
}
