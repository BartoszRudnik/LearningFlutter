import 'package:flutter/material.dart';
import 'package:flutterStarting/AnswerButton.dart';
import 'package:flutterStarting/Question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> _questions;
  final int _questionIndex;
  final Function _testAnswer;

  Quiz(this._questions, this._questionIndex, this._testAnswer);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(
          _questions[_questionIndex]['questionText'],
        ),
        ...(_questions[_questionIndex]['answers'] as List<Map<String, Object>>).map((question) {
          return AnswerButton(question['text'], () => _testAnswer(question['score']));
        }).toList()
      ],
    );
  }
}
