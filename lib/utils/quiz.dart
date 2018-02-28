import './questions.dart';

class Quiz {
  List<Question> _questions; // We can create PRIVATE variables by adding an _ in front of their names
  int _currentQuestionIndex;
  int _score = 0;

  Quiz (this._questions) {
    _questions.shuffle(); //This will randomize the items in the list
  }

  // GETTERS
  List<Question> get questions => _questions;
  int get score => _score;
  int get length => _questions.length;
  int get questionNumber => _currentQuestionIndex+1;

  Question get nextQuestion {
    _currentQuestionIndex++;
    if (_currentQuestionIndex >= _questions.length) return null;
    else {
      Question q = _questions[_currentQuestionIndex];
      return q;
    }
  }

  void answer(bool isCorrect){
    if (isCorrect) _score++;
  }
}