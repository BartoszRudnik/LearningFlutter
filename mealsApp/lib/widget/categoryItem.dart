import 'package:flutter/material.dart';
import 'package:mealsApp/widget/categoryMealsScreen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  CategoryItem({
    @required this.color,
    @required this.title,
  });

  void _selectCategory(BuildContext buildContext) {
    Navigator.of(buildContext).push(
      MaterialPageRoute(builder: (_) {
        return CategoryMealsScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(context),
      splashColor: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Text(
          this.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              this.color.withOpacity(0.7),
              this.color.withOpacity(1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
