import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/model/order.dart';
import 'package:shopApp/widget/mainDrawer.dart';
import 'package:shopApp/widget/orderItemWidget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => OrderItemWidget(
          orderItem: orderData.orders[index],
        ),
        itemCount: orderData.orders.length,
      ),
      drawer: MainDrawer(),
    );
  }
}
