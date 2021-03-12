import 'package:flutter/material.dart';

class MainDrawerItem extends StatelessWidget {
  final String itemName;
  final IconData icon;
  final Function tapHandler;

  MainDrawerItem({
    @required this.tapHandler,
    @required this.itemName,
    @required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        this.icon,
        size: 26,
      ),
      title: Text(
        this.itemName,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
