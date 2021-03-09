import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function _addTransaction;
  Transaction _transaction;

  NewTransaction(this._addTransaction);

  NewTransaction.edit(this._addTransaction, this._transaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _transactionDate;

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        if (value != null) {
          setState(() {
            _transactionDate = value;
          });
        }
      },
    );
  }

  void _submitTransaction() {
    final enteredTitle = _titleInput.text;
    final enteredAmount = double.parse(_amountInput.text);
    String transactionId;

    this.widget._transaction != null ? transactionId = this.widget._transaction.id : transactionId = null;

    if (enteredTitle.isNotEmpty && enteredAmount > 0 && _transactionDate != null) {
      this.widget._addTransaction(
            enteredTitle,
            enteredAmount,
            _transactionDate,
            transactionId,
          );
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    if (this.widget._transaction != null) {
      _titleInput.text = this.widget._transaction.title;
      _amountInput.text = this.widget._transaction.amount.toString();
      this._transactionDate = this.widget._transaction.transactionDate;
    }
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          padding: EdgeInsets.all(5),
          height: constraint.maxHeight,
          child: Card(
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  controller: _titleInput,
                  onSubmitted: (_) => _submitTransaction(),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _amountInput,
                  onSubmitted: (_) => _submitTransaction(),
                ),
                Container(
                  height: constraint.maxHeight * 0.1,
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(_transactionDate == null ? 'No data choosen' : 'Picked date : ${DateFormat.yMMMEd().format(_transactionDate)}'),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: _showDatePicker,
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'Submit transaction',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _submitTransaction,
                  color: Theme.of(context).primaryColorLight,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
