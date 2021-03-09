import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${_listOfTransactions[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _listOfTransactions[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(_listOfTransactions[index].transactionDate),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton.icon(
                          label: Text('Edit'),
                          icon: Icon(Icons.edit_outlined),
                          textColor: Theme.of(context).primaryColorDark,
                          onPressed: () => _editTransaction(
                            context,
                            _listOfTransactions[index],
                          ),
                        ),
                        FlatButton.icon(
                          label: Text('Delete'),
                          icon: Icon(Icons.delete_outline),
                          textColor: Theme.of(context).primaryColorDark,
                          onPressed: () => _deleteTransaction(_listOfTransactions[index].id),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _listOfTransactions.length,
            ),
    );
  }
}
