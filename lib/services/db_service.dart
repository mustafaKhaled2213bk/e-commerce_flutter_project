import 'dart:convert';

import 'package:e_commerce/models/order_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'orders_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        productsIDs TEXT NOT NULL
      )
    ''');
  }


  Future<void> insertOrder(Order order) async {
  Database db = await DatabaseService().database;

  await db.insert('orders', order.toMap());
}




static Future<List<Order>> getAllOrders() async {
  Database db = await DatabaseService().database;

  List<Map<String, dynamic>> ordersData = await db.query('orders');

  List<Order> orders = ordersData.map((orderData) {
    return Order(
      id: orderData['id'],
      date: DateTime.parse(orderData['date']),
      productsIDs: List<int>.from(jsonDecode(orderData['productsIDs'])), // تحويل JSON إلى مصفوفة
    );
  }).toList();

  return orders;
}
}