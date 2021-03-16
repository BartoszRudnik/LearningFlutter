import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart.dart';
import '../model/order.dart';

class OrderButton extends StatefulWidget {
  final Cart cart;

  const OrderButton({
    @required this.cart,
    Key key,
  }) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cart.cartTotal <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Order>(context, listen: false).addOrder(
                widget.cart.itemsInCart.values.toList(),
                widget.cart.cartTotal,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'Order now',
            ),
    );
  }
}
