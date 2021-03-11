import 'package:flutter/material.dart';
import '../model/dummy_data.dart';
import './categoryItem.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DayilyMeal',
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        children: DUMMY_CATEGORIES
            .map(
              (categoryData) => CategoryItem(
                color: categoryData.color,
                title: categoryData.title,
              ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
