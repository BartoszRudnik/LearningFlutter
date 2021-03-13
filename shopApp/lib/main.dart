import 'package:flutter/material.dart';
import 'package:shopApp/screen/productDetailScreen.dart';
import 'package:shopApp/screen/productOverviewScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyShop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.orangeAccent,
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {
        ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
      },
    );
  }
}
