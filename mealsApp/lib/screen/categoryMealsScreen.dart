import 'package:flutter/material.dart';
import 'package:mealsApp/model/meal.dart';
import 'package:mealsApp/widget/mealItem.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen({@required this.availableMeals});

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  String _categoryId;
  List<Meal> _categoryMeals;
  bool _loadedInitData = false;

  void _removeMeal(String mealId) {
    setState(() {
      _categoryMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final args = ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = args['title'];
      _categoryId = args['id'];
      _categoryMeals = this.widget.availableMeals.where(
        (meal) {
          return meal.categories.contains(_categoryId);
        },
      ).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _categoryTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            removeItem: _removeMeal,
            id: _categoryMeals[index].id,
            affordability: _categoryMeals[index].affordability,
            complexity: _categoryMeals[index].complexity,
            duration: _categoryMeals[index].duration,
            imageUrl: _categoryMeals[index].imageUrl,
            title: _categoryMeals[index].title,
          );
        },
        itemCount: _categoryMeals.length,
      ),
    );
  }
}
