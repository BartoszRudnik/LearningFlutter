import 'package:flutter/material.dart';
import 'package:flutterStarting/answerButton.dart';
import 'package:flutterStarting/question.dart';

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  void _testAnswer() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex += 1;
      });
    }
    print(_questionIndex);
  }

  var _questionIndex = 0;

  final _questions = [
    {
      'questionText': 'What is your favorite color?',
      'answers': ['Black', 'Red', 'Blue']
    },
    {
      'questionText': 'What is your favorite city?',
      'answers': ['London', 'Paris', 'Barcelona']
    },
    {
      'questionText': 'What is your favorite animal?',
      'answers': ['Cat', 'Dog', 'Rabbit']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My title'),
        ),
        body: Column(
          children: [
            Question(
              _questions[_questionIndex]['questionText'],
            ),
            ...(_questions[_questionIndex]['answers'] as List<String>).map((question) {
              return answerButton(question, _testAnswer);
            }).toList()
          ],
        ),
      ),
    );
  }
}
