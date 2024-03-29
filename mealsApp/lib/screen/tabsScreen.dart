import 'package:flutter/material.dart';
import 'package:mealsApp/model/meal.dart';
import 'package:mealsApp/screen/categoriesScreen.dart';
import 'package:mealsApp/screen/favoritesScreen.dart';
import 'package:mealsApp/widget/mainDrawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TabsScreen({
    @required this.favoriteMeals,
  });

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  @override
  void initState() {
    _pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(
          favoritesMeals: this.widget.favoriteMeals,
        ),
        'title': 'Your Favorite',
      }
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    if (index >= 0 && index < _pages.length) {
      setState(() {
        _selectedPageIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity < 0) {
          _selectPage(_selectedPageIndex + 1);
          print(_selectedPageIndex);
        }
        if (details.primaryVelocity > 0) {
          _selectPage(_selectedPageIndex - 1);
          print(_selectedPageIndex);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedPageIndex]['title']),
        ),
        drawer: MainDrawer(),
        body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: _selectedPageIndex,
          // type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
