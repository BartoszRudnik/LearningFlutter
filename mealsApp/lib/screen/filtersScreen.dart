import 'package:flutter/material.dart';
import 'package:mealsApp/widget/mainDrawer.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      body: Center(
        child: Text(
          'Filters',
        ),
      ),
      drawer: MainDrawer(),
    );
  }
}
