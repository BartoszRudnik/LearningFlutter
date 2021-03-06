import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:PersonalExpensesApp/widgets/newTransaction.dart';
import 'package:PersonalExpensesApp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _listOfTransactions = [
    Transaction(25.24, 't1', 'New shoes', DateTime.now()),
    Transaction(901.23, 't2', 'Apartment rent', DateTime.now()),
  ];

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
            Container(
              width: double.infinity,
              child: Card(
                child: Text('CHART!'),
                elevation: 5,
              ),
            ),
            TransactionList(_listOfTransactions)
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
