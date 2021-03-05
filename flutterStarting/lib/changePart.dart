import 'package:flutter/material.dart';
import 'package:flutterStarting/EndOfQuiz.dart';
import 'package:flutterStarting/Quiz.dart';

class ChangePart extends StatefulWidget {
  @override
  _ChangePartState createState() => _ChangePartState();
}

class _ChangePartState extends State<ChangePart> {
  var _questionIndex = 0;
  var _nextQuestion = true;
  var _totalScore = 0;

  final _questions = const [
    {
      'questionText': 'What is your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Blue', 'score': 15},
        {'text': 'Red', 'score': 5},
      ]
    },
    {
      'questionText': 'What is your favorite city?',
      'answers': [
        {'text': 'London', 'score': 15},
        {'text': 'Paris', 'score': 5},
        {'text': 'Zabrze', 'score': 35},
      ]
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': [
        {'text': 'Cat', 'score': 5},
        {'text': 'Dog', 'score': 10},
        {'text': 'Rabbit', 'score': 15},
      ]
    },
  ];

  void _testAnswer(int questionScore) {
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex += 1;
      } else {
        _nextQuestion = false;
      }
      _totalScore += questionScore;
    });
    print(_questionIndex);
    print(_nextQuestion);
    print(_totalScore);
  }

  void _clearQuiz() {
    setState(() {
      _questionIndex = 0;
      _nextQuestion = true;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _nextQuestion ? Quiz(_questions, _questionIndex, _testAnswer) : EndOfQuiz(_totalScore, _clearQuiz);
  }
}
