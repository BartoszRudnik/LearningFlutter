import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();

  Function _addTransaction;

  NewTransaction(this._addTransaction);

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
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountInput,
            ),
            FlatButton(
              child: Text('Submit transaction'),
              onPressed: () => {
                _addTransaction(_titleInput.text, double.parse(_amountInput.text)),
              },
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
