import 'package:flutter/material.dart';
import '../utils/quiz.dart';
import '../utils/questions.dart';
import '../UI/answer_button.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context){
    return new Stack( // Similar to a coulmn. A Stack will stack widgets on TOP of each other
      children: <Widget>[
        new Column( // This is our main page
        children: <Widget>[
          new AnswerButton(true, () => print("You answered true")),
          new AnswerButton(false,() => print("You answered false"))
        ],
        ),
      ]
    );
  }
}