import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final String _answerText;
  final Function _testAnswer;

  AnswerButton(this._answerText, this._testAnswer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.lightBlue,
        textColor: Colors.black87,
        child: Text(_answerText),
        onPressed: _testAnswer,
      ),
    );
  }
}
