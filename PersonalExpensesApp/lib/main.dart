import 'dart:io';

import 'package:PersonalExpensesApp/widgets/homePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            title: 'Personal Expenses',
            home: MyHomePage(),
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
              accentColor: Colors.teal,
              fontFamily: 'QuickSand',
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
              ),
            ),
          )
        : CupertinoApp(
            title: 'Personal Expenses',
            home: MyHomePage(),
            theme: CupertinoThemeData(
              primaryColor: Colors.blueGrey,
              primaryContrastingColor: Colors.teal,
            ),
          );
  }
}
