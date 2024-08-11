import 'package:e_commerce/providers/order_notifier.dart';
import 'package:e_commerce/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    OrderNotifier orderProvider = Provider.of<OrderNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderWidget(
              order: orderProvider.orders.reversed.toList()[index]);
        },
        itemCount: orderProvider.orders.length,
      ),
    );
  }
}
