import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String _weekDayLabel;
  final double _spendingAmount;
  final double _spendingPercent;

  ChartBar(this._spendingAmount, this._spendingPercent, this._weekDayLabel);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: <Widget>[
            Container(
              height: constraint.maxHeight * 0.1,
              child: FittedBox(
                child: Text(
                  '\$${_spendingAmount.toStringAsFixed(0)}',
                ),
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.03,
            ),
            Container(
              height: constraint.maxHeight * 0.6,
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: _spendingPercent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.1,
            ),
            FittedBox(
              child: Text(
                _weekDayLabel,
              ),
            ),
          ],
        );
      },
    );
  }
}
