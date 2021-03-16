import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopApp/exception/httpException.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    var url = 'https://learningflutter-81fa2-default-rtdb.firebaseio.com/products/${this.id}.json';
    var oldFavoriteStatus = this.isFavorite;

    this.isFavorite = !this.isFavorite;
    notifyListeners();

    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': this.isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        throw new HttpException('Could not change favorite');
      }
    } catch (error) {
      this.isFavorite = oldFavoriteStatus;
      notifyListeners();
      throw error;
    } finally {
      oldFavoriteStatus = null;
    }
  }
}
