import 'package:flutter/material.dart';

class MealDetailsInsideTitle extends StatelessWidget {
  final String title;
  final BuildContext context;

  MealDetailsInsideTitle({
    @required this.title,
    @required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        this.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
