import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final int qId;
  final Function answerHandler;

  Quiz({@required this.answerHandler, @required this.qId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question("Question $qId"),
        ...(["A", "B", "C", "D"]).map((answer) {
          return Answer(answer, () => answerHandler(answer));
        }).toList(),
      ],
    );
  }
}
