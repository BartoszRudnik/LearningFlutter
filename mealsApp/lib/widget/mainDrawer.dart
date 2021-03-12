import 'package:flutter/material.dart';
import 'package:mealsApp/screen/filtersScreen.dart';
import 'package:mealsApp/widget/mainDrawerItem.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MainDrawerItem(
            tapHandler: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            itemName: 'Meals',
            icon: Icons.restaurant,
          ),
          MainDrawerItem(
            tapHandler: () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            },
            itemName: 'Filtres',
            icon: Icons.settings,
          ),
        ],
      ),
    );
  }
}
