import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:PersonalExpensesApp/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  bool _compareDates(DateTime firstDate, DateTime secondDate) {
    // TO-DO -> metoda realizujaca funkcjonalnosc z linii 32
    return false;
  }

  double get _weekSpending {
    double spending = 0.0;
    _groupedTransactionsValues.forEach((element) {
      spending += element['amount'];
    });
    return spending;
  }

  List<Map<String, Object>> get _groupedTransactionsValues {
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
        'day': DateFormat.E().format(weekDay),
        'amount': dayTotalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactionsValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['amount'],
                _weekSpending == 0.0 ? 0.0 : (data['amount'] as double) / _weekSpending,
                data['day'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
