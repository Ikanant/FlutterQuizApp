import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final bool _answer;
  final VoidCallback _onTap;

  AnswerButton (this._answer, this._onTap);

  @override
  Widget build(BuildContext context) {
    String answerText = _answer ? "true" : "false";

    return new Expanded(
      child: new Material(
        color: _answer ? Colors.greenAccent : Colors.redAccent,
        child: new InkWell(
          onTap: () => _onTap(),
          child: new Center (child: new Container(
            child: new Text(answerText),
          ),)
        )
      ),
    );
  }
}