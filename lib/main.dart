import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/model/question.dart';

void main() {
  for (int i = 0; i < _questionJson.length; ++i) {
    debugPrint(_questionJson[i]["question"]);
    List<String> templist =
        List<String>.from(_questionJson[i]["options"] as List);
    // print(templist);
    _questionObjects.add(Question(
        _questionJson[i]["question"], templist, _questionJson[i]["answer"]));
    // print(_questionObjects[i].options);
  }

  runApp(MaterialApp(home: QuizApp()));
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<QuizApp> createState() => _QuizAppState();
}

List _questionObjects = <Question>[];

int _currQuestion = 0;
int _totalScore = 0;
var _questionBank = '''[
  {
    "question": "Who is the current Prime Minister of Canada?",
    "options": [
      "Justin Trudeau",
      "Andrew Scheer",
      "Jagmeet Singh",
      "Elizabeth May"
    ],
    "answer": "Justin Trudeau"
  },
  {
    "question": "What is the capital city of Canada?",
    "options": [
      "Toronto",
      "Vancouver",
      "Ottawa",
      "Montreal"
    ],
    "answer": "Ottawa"
  },
  {
    "question": "Which province is known as the 'Land of the Maple'?",
    "options": [
      "Quebec",
      "British Columbia",
      "Alberta",
      "Ontario"
    ],
    "answer": "Quebec"
  },
  {
    "question": "What is the national symbol of Canada?",
    "options": [
      "Bald Eagle",
      "Beaver",
      "Moose",
      "Maple Leaf"
    ],
    "answer": "Maple Leaf"
  },
  {
    "question": "Which ocean is on the east coast of Canada?",
    "options": [
      "Atlantic Ocean",
      "Pacific Ocean",
      "Indian Ocean",
      "Arctic Ocean"
    ],
    "answer": "Atlantic Ocean"
  },
  {
    "question": "In which year did Canada become a country?",
    "options": [
      "1867",
      "1776",
      "1917",
      "1954"
    ],
    "answer": "1867"
  },
  {
    "question": "What is the official language of Canada?",
    "options": [
      "English",
      "French",
      "Spanish",
      "German"
    ],
    "answer": "English and French"
  },
  {
    "question": "Which Canadian province is the largest by land area?",
    "options": [
      "Ontario",
      "Quebec",
      "Alberta",
      "British Columbia"
    ],
    "answer": "Quebec"
  },
  {
    "question": "What is the currency of Canada?",
    "options": [
      "Dollar",
      "Euro",
      "Pound",
      "Yen"
    ],
    "answer": "Dollar"
  },
  {
    "question": "What is the name of the famous waterfall located on the border of Canada and the United States?",
    "options": [
      "Niagara Falls",
      "Victoria Falls",
      "Angel Falls",
      "Iguazu Falls"
    ],
    "answer": "Niagara Falls"
  }
]
''';

var _questionJson = json.decode(_questionBank);

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
        color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
        title: Text('True Citizen'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "images/flag.jpeg",
              width: 400,
              height: 180,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                _questionObjects[_currQuestion].questionText,
                style: textStyle,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => _checkAnswer(
                          _questionObjects[_currQuestion].options[0]),
                      child: Text(_questionObjects[_currQuestion].options[0])),
                  ElevatedButton(
                      onPressed: () => _checkAnswer(
                          _questionObjects[_currQuestion].options[1]),
                      child: Text(_questionObjects[_currQuestion].options[1]))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => _checkAnswer(
                          _questionObjects[_currQuestion].options[2]),
                      child: Text(_questionObjects[_currQuestion].options[2])),
                  ElevatedButton(
                      onPressed: () => _checkAnswer(
                          _questionObjects[_currQuestion].options[3]),
                      child: Text(_questionObjects[_currQuestion].options[3]))
                ],
              ),
            ),
            Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total Score",
                      style: TextStyle(
                          color: Colors.indigo.shade700,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    Text("$_totalScore",
                        style: TextStyle(
                            color: Colors.indigo.shade700,
                            fontSize: 17,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  _checkAnswer(option) {
    debugPrint("clicked $option");
    var snackPrompt = "";
    if (option == _questionObjects[_currQuestion].correctAnswer) {
      snackPrompt = "Correct!";
    } else {
      snackPrompt = "Incorrect!";
    }
    final snackBar = SnackBar(
      content: Text(snackPrompt),
      duration: Duration(milliseconds: 500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      if (snackPrompt == "Correct!") {
        _totalScore += 1;
        if (_currQuestion == 9) {
          _currQuestion = 0;
          _totalScore = 0;
        } else {
          _currQuestion += 1;
        }
      } else {
        if (_currQuestion == 9) {
          _currQuestion = 0;
          _totalScore = 0;
        } else {
          _currQuestion += 1;
        }
      }
    });
  }
}
