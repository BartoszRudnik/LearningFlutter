import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:PersonalExpensesApp/widgets/chart.dart';
import 'package:PersonalExpensesApp/widgets/newTransaction.dart';
import 'package:PersonalExpensesApp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _listOfTransactions = [];

  int _dayDifference(DateTime today, DateTime transactionDate) {
    return today.difference(transactionDate).inDays;
  }

  List<Transaction> get _recentTrsansactions {
    return _listOfTransactions.where((transaction) {
      return _dayDifference(DateTime.now(), transaction.transactionDate) <= 7;
    }).toList();
  }

  void _addTransaction(String title, double amount) {
    final newUserTransaction = Transaction(
      amount,
      DateTime.now().toString(),
      title,
      DateTime.now(),
    );

    setState(() {
      _listOfTransactions.add(newUserTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Chart(_recentTrsansactions),
            TransactionList(_listOfTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
