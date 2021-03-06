import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();

  void submitTransaction() {
    final enteredTitle = _titleInput.text;
    final enteredAmount = double.parse(_amountInput.text);

    if (enteredTitle.isNotEmpty && enteredAmount > 0) {
      this.widget._addTransaction(
            enteredTitle,
            enteredAmount,
          );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _amountInput,
              onSubmitted: (_) => submitTransaction(),
            ),
            FlatButton(
              child: Text('Submit transaction'),
              onPressed: submitTransaction,
              textColor: Theme.of(context).primaryColorDark,
            )
          ],
        ),
      ),
    );
  }
}
