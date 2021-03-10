import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:PersonalExpensesApp/widgets/transactionItem.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _listOfTransactions;
  Function _deleteTransaction;
  Function _editTransaction;

  TransactionList(
    this._listOfTransactions,
    this._deleteTransaction,
    this._editTransaction,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: _listOfTransactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraint) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'No transactions',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: constraint.maxHeight * 0.1,
                      width: 10,
                    ),
                    Container(
                      height: constraint.maxHeight * 0.65,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                  key: ValueKey(_listOfTransactions[index].id),
                  transaction: _listOfTransactions[index],
                  editTransaction: _editTransaction,
                  deleteTransaction: _deleteTransaction,
                );
              },
              itemCount: _listOfTransactions.length,
            ),
    );
  }
}
