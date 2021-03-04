import 'package:flutter/material.dart';

class EndOfQuiz extends StatelessWidget {
  final int _totalScore;
  final Function _clearQuiz;

  EndOfQuiz(this._totalScore, this._clearQuiz);

  String _ratePerson(int finalScore) {
    if (finalScore > 40) {
      return "You are crazy";
    } else if (finalScore > 25 && finalScore <= 40) {
      return "You are probably crazy";
    } else {
      return "You are normal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            _ratePerson(_totalScore),
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: _clearQuiz,
            child: Text("Restart Quiz!"),
          ),
        ],
      ),
    );
  }
}
