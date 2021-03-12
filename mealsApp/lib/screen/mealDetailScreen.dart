import 'package:flutter/material.dart';
import 'package:mealsApp/model/dummy_data.dart';
import 'package:mealsApp/model/meal.dart';
import 'package:mealsApp/widget/mealDetailInsideChild.dart';
import 'package:mealsApp/widget/mealDetailsInsideTitle.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/category-meals/meal-detail';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String id = args['id'];
    final String title = args['title'];
    final Meal selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            MealDetailsInsideTitle(
              title: 'Ingredients',
              context: context,
            ),
            MealDetailInsideChild(
              childWidget: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            MealDetailsInsideTitle(
              title: 'Steps',
              context: context,
            ),
            MealDetailInsideChild(
              childWidget: ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '# ${(index + 1)}',
                        ),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                      ),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
