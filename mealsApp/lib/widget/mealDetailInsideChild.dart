import 'package:flutter/material.dart';

class MealDetailInsideChild extends StatelessWidget {
  final Widget childWidget;

  MealDetailInsideChild({
    @required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          color: Colors.blueGrey,
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 250,
      width: 300,
      child: childWidget,
    );
  }
}
