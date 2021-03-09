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
  bool _showChart = false;

  int _dayDifference(DateTime today, DateTime transactionDate) {
    return today.difference(transactionDate).inDays;
  }

  List<Transaction> get _recentTrsansactions {
    return _listOfTransactions.where((transaction) {
      return _dayDifference(DateTime.now(), transaction.transactionDate) <= 7;
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime transactionDate, String transactionId) {
    if (transactionId != null) {
      setState(() {
        Transaction transaction = _listOfTransactions.firstWhere((element) => element.id == transactionId);

        transaction.amount = amount;
        transaction.title = title;
        transaction.transactionDate = transactionDate;
      });
    } else {
      final newUserTransaction = Transaction(
        amount,
        DateTime.now().toString(),
        title,
        transactionDate,
      );

      setState(() {
        _listOfTransactions.add(newUserTransaction);
      });
    }
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

  void _deleteTransaction(String id) {
    setState(() {
      _listOfTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _editTransaction(BuildContext buildContext, Transaction transaction) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction.edit(_addTransaction, transaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch(
                    value: _showChart,
                    onChanged: (value) {
                      setState(
                        () {
                          _showChart = value;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.75,
                    child: Chart(_recentTrsansactions),
                  )
                : Container(
                    height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.85,
                    child: Expanded(
                      child: TransactionList(_listOfTransactions, _deleteTransaction, _editTransaction),
                    ),
                  ),
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
