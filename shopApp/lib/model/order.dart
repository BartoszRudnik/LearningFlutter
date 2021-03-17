import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';
import 'orderItem.dart';

class Order with ChangeNotifier {
  List<OrderItem> ordersList = [];
  final String authToken;
  final String userId;

  Order({
    @required this.userId,
    @required this.authToken,
    @required this.ordersList,
  });

  List<OrderItem> get orders {
    return [...ordersList];
  }

  Future<void> fetchOrders() async {
    final url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/orders/${this.userId}.json?auth=${this.authToken}';

    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrders = [];
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData != null) {
        extractedData.forEach((orderId, orderData) {
          loadedOrders.add(
            OrderItem(
              id: orderId,
              amount: orderData['amount'],
              dateTime: DateTime.parse(orderData['dateTime']),
              products: (orderData['products'] as List<dynamic>)
                  .map(
                    (item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      quantity: item['quantity'],
                      price: item['price'],
                    ),
                  )
                  .toList(),
            ),
          );
        });
      }
      ordersList = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/orders/${this.userId}.json?auth=${this.authToken}';

    final orderTimeStamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': orderTimeStamp.toIso8601String(),
          'id': orderTimeStamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList()
        }),
      );

      ordersList.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: orderTimeStamp,
        ),
      );

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
