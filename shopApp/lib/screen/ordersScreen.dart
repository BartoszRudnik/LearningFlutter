import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/model/order.dart';
import 'package:shopApp/widget/mainDrawer.dart';
import 'package:shopApp/widget/orderItemWidget.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Order>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your orders'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (context, index) => OrderItemWidget(
                orderItem: orderData.orders[index],
              ),
              itemCount: orderData.orders.length,
            ),
      drawer: MainDrawer(),
    );
  }
}
