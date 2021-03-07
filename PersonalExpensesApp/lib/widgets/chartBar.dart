import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _weekDayLabel;
  final double _spendingAmount;
  final double _spendingPercent;

  ChartBar(this._spendingAmount, this._spendingPercent, this._weekDayLabel);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(
          child: Text(
            '\$${_spendingAmount.toStringAsFixed(0)}',
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(222, 222, 222, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                heightFactor: _spendingPercent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          _weekDayLabel,
        ),
      ],
    );
  }
}
