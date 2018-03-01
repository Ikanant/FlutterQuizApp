import 'package:flutter/material.dart';
import '../utils/quiz.dart';
import '../utils/questions.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("This app is cool", true),
    new Question("Pizza is healthy", false),
    new Question("I am hungry", true)
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;

  bool overlayShouldBeVisible = false;

  @override
  void initState(){
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }
  
  @override
  Widget build(BuildContext context){
    return new Stack( // Similar to a coulmn. A Stack will stack widgets on TOP of each other
      fit: StackFit.expand,
      children: <Widget>[
        new Column( // This is our main page
          children: <Widget>[
            new AnswerButton(true,  () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        overlayShouldBeVisible ? new CorrectWrongOverlay(isCorrect, () { 
          currentQuestion = quiz.nextQuestion;
          this.setState( () {
            overlayShouldBeVisible = false;
            questionText = currentQuestion.question;
            questionNumber = quiz.questionNumber;
          });
         }) : new Container() // Empty container doesn't display anything
      ]
    );
  }

  void handleAnswer (bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState((){ // We need to change the state in order to rebuild the widget
      overlayShouldBeVisible = true;
    });
  }
}