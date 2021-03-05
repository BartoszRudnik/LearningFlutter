import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _listOfTransactions;

  TransactionList(this._listOfTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: _listOfTransactions.map((transaction) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    border: Border.all(
                      color: Colors.black87,
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ ${transaction.amount}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(transaction.transactionDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
