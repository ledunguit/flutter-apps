import 'package:first_app/cache.dart';
import 'package:first_app/env_button.dart';
import 'package:first_app/picker.dart';
import 'package:first_app/quiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  int _qid = 1;
  int totalScore = 0;
  bool isSelected = true;
  String env = "TEST";

  Cache cache = new Cache();

  void addScore(String answer) {
    cache.init();
    print("REDIS $env => $_qid and $answer");
    cache.save(env, _qid, answer);
  }

  void _toggleHandler(bool isSelect) {
    print("Is Select: $isSelected $isSelect");
    if (isSelect) {
      this.env = "TEST";
    } else {
      this.env = "RESULT";
    }
    setState(() {
      isSelected = isSelect;
    });
  }

  void _answerHandler(String answer) {
    addScore(answer);
    print("Answering question $_qid");
  }

  void _pickerHander(int id) {
    setState(() {
      this._qid = id;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Toeic Picker App"),
              titleSpacing: 1,
            ),
            body: Column(
              children: [
                EnvButton(
                  isSelected: isSelected,
                  selectHandler: _toggleHandler,
                  env: this.env,
                ),
                Quiz(
                  answerHandler: _answerHandler,
                  qId: _qid,
                ),
                Picker(qId: _qid, pickerHander: _pickerHander),
              ],
            )));
  }
}
