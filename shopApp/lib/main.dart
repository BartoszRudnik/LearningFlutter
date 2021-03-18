import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopApp/helpers/customRoute.dart';

import 'model/cart.dart';
import 'model/order.dart';
import 'provider/auth.dart';
import 'provider/productsProvider.dart';
import 'screen/authScreen.dart';
import 'screen/cartScreen.dart';
import 'screen/manageProductScreen.dart';
import 'screen/ordersScreen.dart';
import 'screen/productDetailScreen.dart';
import 'screen/productOverviewScreen.dart';
import 'screen/splashScreen.dart';
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
            userId: auth.userId,
            itemsList: previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: null,
          update: (ctx, auth, previousOrders) => Order(
            userId: auth.userId,
            authToken: auth.token,
            ordersList: previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, ch) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.orangeAccent,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: authData.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResult) => authResult.connectionState == ConnectionState.waiting ? SplashScreen() : AuthScreen(),
                ),
          routes: {
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
