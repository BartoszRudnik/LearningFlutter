import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../exception/httpException.dart';
import '../model/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl: 'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return [..._items.where((element) => element.isFavorite)];
  }

  Future<void> updateProduct(String id, Product product) async {
    var url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/products/$id.json';

    var productIndex = _items.indexWhere(
      (element) => element.id == id,
    );

    if (productIndex >= 0) {
      try {
        await http.patch(
          url,
          body: json.encode(
            {
              'title': product.title,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'description': product.description,
              'isFavorite': product.isFavorite,
            },
          ),
        );
      } catch (error) {
        throw error;
      }
      _items[productIndex] = product;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchProducts() async {
    const url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            title: prodData['title'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteProduct(String productId) async {
    var url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/products/$productId.json';

    var existingProduct = _items.firstWhere((element) => element.id == productId);
    _items.removeWhere((element) => element.id == productId);

    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        throw HttpException('Wrong product id');
      }
      existingProduct = null;
    } catch (error) {
      _items.add(existingProduct);
      throw error;
    }

    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
