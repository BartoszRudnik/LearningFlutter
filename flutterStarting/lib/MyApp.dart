import 'package:flutter/material.dart';
import 'package:flutterStarting/changePart.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My title'),
        ),
        body: ChangePart(),
      ),
    );
  }
}
