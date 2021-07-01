import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pong_game/ball.dart';
import 'package:pong_game/brick.dart';
import 'package:pong_game/coverscreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ball
  double ballX = 0;
  double ballY = 0;

  // setting
  bool isGameStarted = false;

  void startGame() {
    if (this.isGameStarted == false) {
      isGameStarted = true;
      Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          ballY += 0.01;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
            child: Stack(
          children: [
            CoverScreen(started: this.isGameStarted),
            MyBrick(
              x: 0,
              y: -0.8,
            ),
            MyBrick(
              x: 0,
              y: 0.8,
            ),
            MyBall(x: ballX, y: ballY)
          ],
        )),
      ),
    );
  }
}
