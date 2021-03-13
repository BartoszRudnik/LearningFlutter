import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _itemsInCart = {};

  Map<String, CartItem> get itemsInCart {
    return {..._itemsInCart};
  }

  int get itemCount {
    int sum = 0;

    _itemsInCart.values.forEach(
      (element) {
        sum += element.quantity;
      },
    );

    return sum;
  }

  void addItem(String productId, double price, String title) {
    if (_itemsInCart.containsKey(productId)) {
      _itemsInCart.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
              ));
    } else {
      _itemsInCart.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }

    notifyListeners();
  }
}
