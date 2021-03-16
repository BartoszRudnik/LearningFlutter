import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';
import '../widget/cartItemWidget.dart';
import '../widget/orderButton.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 20),
                  ),
                  Consumer<Cart>(
                    builder: (context, cart, child) => Chip(
                      label: Text(
                        '\$' + cart.cartTotal.toStringAsFixed(2),
                        style: TextStyle(
                          color: Theme.of(context).primaryTextTheme.headline6.color,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  Consumer<Cart>(
                    builder: (context, cart, child) => OrderButton(cart: cart),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Consumer<Cart>(
            builder: (context, cart, ch) => Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => CartItemWidget(
                  productId: cart.itemsInCart.keys.toList()[index],
                  id: cart.itemsInCart.values.toList()[index].id,
                  price: cart.itemsInCart.values.toList()[index].price,
                  quantity: cart.itemsInCart.values.toList()[index].quantity,
                  title: cart.itemsInCart.values.toList()[index].title,
                ),
                itemCount: cart.poisitionsCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
