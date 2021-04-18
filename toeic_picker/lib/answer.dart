import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerStr;
  final Function selectHandler;

  Answer(this.answerStr, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 200,
      margin: EdgeInsets.all(10),
      child: ElevatedButton(
        style: TextButton.styleFrom(
            primary: Colors.blue,
            backgroundColor: Colors.greenAccent,
            shadowColor: Colors.deepPurple,
            onSurface: Colors.pink),
        child: Text(answerStr),
        onPressed: this.selectHandler,
      ),
    );
  }
}
