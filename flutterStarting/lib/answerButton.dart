import 'package:flutter/material.dart';

class answerButton extends StatelessWidget {
  final String _answerText;
  final Function _selectHandler;

  answerButton(this._answerText, this._selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.lightBlue,
        textColor: Colors.black87,
        child: Text(_answerText),
        onPressed: _selectHandler,
      ),
    );
  }
}
