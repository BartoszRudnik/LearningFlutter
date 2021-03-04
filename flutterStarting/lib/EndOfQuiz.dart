import 'package:flutter/material.dart';

class EndOfQuiz extends StatelessWidget {
  final String _returnMessage;

  EndOfQuiz(this._returnMessage);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_returnMessage),
    );
  }
}
