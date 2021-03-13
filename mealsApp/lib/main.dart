import 'package:flutter/material.dart';
import 'package:mealsApp/model/dummy_data.dart';
import 'package:mealsApp/model/meal.dart';
import 'package:mealsApp/screen/categoriesScreen.dart';
import 'package:mealsApp/screen/categoryMealsScreen.dart';
import 'package:mealsApp/screen/filtersScreen.dart';
import 'package:mealsApp/screen/mealDetailScreen.dart';
import 'package:mealsApp/screen/tabsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filtres = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFiltres(Map<String, bool> filterData) {
    setState(() {
      _filtres = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filtres['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filtres['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filtres['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filtres['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _checkIfFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((element) => element.id == mealId);

    if (existingIndex != -1) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((element) => element.id == mealId),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DayliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(254, 222, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              checkIfFavorite: this._checkIfFavorite,
              toggleFavorite: this._toggleFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              setFilters: _setFiltres,
              filtres: _filtres,
            ),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
