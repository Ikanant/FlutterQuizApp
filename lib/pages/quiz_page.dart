import 'package:flutter/material.dart';
import '../utils/quiz.dart';
import '../utils/questions.dart';
import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';
import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("You must brush and floss your teeth after every meal to prevent gum disease and cavities.", false),
    new Question("Brushing your teeth with an up-and-down or side-to-side motion is the best way to clean your teeth.", false),
    new Question("You can floss your teeth by simply putting the floss between your teeth and pulling it through.", false),
    new Question("Toothbrushes with angled heads and 2 levels of bristles are better than those with straight heads and 1 level of bristles.", true),
    new Question("Motorized toothbrushes clean your teeth better than manual brushes.", false),
    new Question("Brushing too much can harm your gums.", false),
    new Question("You should use a dental rinse along with brushing and flossing to remove plaque.", false),
    new Question("Toothpastes that contain baking soda and hydrogen peroxide can help reduce plaque acids made by plaque bacteria.", true),
    new Question("You should see your dentist twice a year for checkups and cleanings.", true),
    new Question("If your parents lost all their teeth to tooth decay or gum disease, you will too.", false),
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
          if (quiz.length == questionNumber) {
            Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
            return;
          }

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