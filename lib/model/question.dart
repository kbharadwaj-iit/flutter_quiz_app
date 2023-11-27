import 'dart:core';

class Question {
  String questionText;
  List<String> options;
  String correctAnswer;
  get getQuestionText => this.questionText;

  set setQuestionText(questionText) => this.questionText = questionText;

  get getOptions => this.options;

  set setOptions(options) => this.options = options;

  get getCorrectAnswer => this.correctAnswer;

  set setCorrectAnswer(correctAnswer) => this.correctAnswer = correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}
