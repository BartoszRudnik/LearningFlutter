import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required Transaction transaction,
    @required Function editTransaction,
    @required Function deleteTransaction,
  })  : _transaction = transaction,
        _editTransaction = editTransaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _transaction;
  final Function _editTransaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
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
              child: Text('\$${_transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(_transaction.transactionDate),
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
                _transaction,
              ),
            ),
            FlatButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete_outline),
              textColor: Theme.of(context).primaryColorDark,
              onPressed: () => _deleteTransaction(_transaction.id),
            ),
          ],
        ),
      ),
    );
  }
}
