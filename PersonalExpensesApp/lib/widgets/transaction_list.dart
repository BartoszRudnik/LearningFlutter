import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _listOfTransactions;

  TransactionList(this._listOfTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      style: BorderStyle.solid,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$ ${_listOfTransactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _listOfTransactions[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMMd().format(_listOfTransactions[index].transactionDate),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: _listOfTransactions.length,
      ),
    );
  }
}
