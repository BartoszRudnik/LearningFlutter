import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/provider/auth.dart';
import 'package:shopApp/screen/authScreen.dart';

import 'model/cart.dart';
import 'model/order.dart';
import 'provider/productsProvider.dart';
import 'screen/cartScreen.dart';
import 'screen/manageProductScreen.dart';
import 'screen/ordersScreen.dart';
import 'screen/productDetailScreen.dart';
import 'screen/productOverviewScreen.dart';
import 'screen/userProductScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductsProvider>(
          create: null,
          update: (ctx, auth, previousProducts) => ProductsProvider(
            authToken: auth.token,
            itemsList: previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Order(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, child) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orangeAccent,
            fontFamily: 'Lato',
          ),
          home: authData.isAuth ? ProductOverviewScreen() : AuthScreen(),
          routes: {
            ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
            ManageProductScreen.routeName: (ctx) => ManageProductScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          },
        ),
      ),
    );
  }
}
