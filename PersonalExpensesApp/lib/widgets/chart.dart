import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  bool compareDates(DateTime firstDate, DateTime secondDate) {
    // TO-DO
  }

  List<Map<String, Object>> get GroupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double dayTotalSum = 0.0;

      for (var i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].transactionDate.day == weekDay.day && _recentTransactions[i].transactionDate.month == weekDay.month && _recentTransactions[i].transactionDate.year == weekDay.year) {
          dayTotalSum += _recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E(weekDay),
        'amount': dayTotalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
