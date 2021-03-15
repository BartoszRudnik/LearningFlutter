import 'package:flutter/material.dart';
import 'package:shopApp/model/cart.dart';
import 'package:shopApp/model/order.dart';
import 'package:shopApp/provider/productsProvider.dart';
import 'package:shopApp/screen/cartScreen.dart';
import 'package:shopApp/screen/ordersScreen.dart';
import 'package:shopApp/screen/productDetailScreen.dart';
import 'package:shopApp/screen/productOverviewScreen.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/screen/userProductScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Order(),
        )
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orangeAccent,
          fontFamily: 'Lato',
        ),
        home: ProductOverviewScreen(),
        routes: {
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
