import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:PersonalExpensesApp/widgets/newTransaction.dart';
import 'package:PersonalExpensesApp/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_addTransaction),
        TransactionList(_listOfTransactions),
      ],
    );
  }
}
