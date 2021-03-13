import 'package:flutter/material.dart';
import 'package:mealsApp/model/meal.dart';
import 'package:mealsApp/widget/mealItem.dart';

class FavoritesScreen extends StatelessWidget {
  List<Meal> favoritesMeals;

  FavoritesScreen({
    @required this.favoritesMeals,
  });

  @override
  Widget build(BuildContext context) {
    if (favoritesMeals.length == 0)
      return Center(
        child: Text(
          'You have no favorites meals',
        ),
      );
    else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            removeItem: () {},
            id: favoritesMeals[index].id,
            affordability: favoritesMeals[index].affordability,
            complexity: favoritesMeals[index].complexity,
            duration: favoritesMeals[index].duration,
            imageUrl: favoritesMeals[index].imageUrl,
            title: favoritesMeals[index].title,
          );
        },
        itemCount: favoritesMeals.length,
      );
    }
  }
}
