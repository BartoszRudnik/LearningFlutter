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

  int get poisitionsCount {
    return _itemsInCart.length;
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

  double get cartTotal {
    double sum = 0.0;

    _itemsInCart.values.forEach((element) {
      sum += (element.price * element.quantity);
    });

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

  void removeItem(String productId) {
    _itemsInCart.remove(productId);

    notifyListeners();
  }

  void clear() {
    _itemsInCart = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_itemsInCart.containsKey(productId)) {
      if (_itemsInCart[productId].quantity > 1) {
        _itemsInCart.update(
            productId,
            (item) => CartItem(
                  id: item.id,
                  title: item.title,
                  quantity: item.quantity - 1,
                  price: item.price,
                ));
      } else {
        removeItem(productId);
      }
    }
    notifyListeners();
  }
}
