import 'dart:async';
import 'dart:math';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flappy_bird/scoreboard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Bird {
  double height, width;
  Bird(this.height, this.width);
}

class Barrier {
  double x, y, w, h;
  Barrier(this.x, this.y, this.w, this.h);
}

class Score {
  int score, best;

  Score(this.score, this.best);

  void updateScore() {
    score += 1;
    if (best < score) {
      best = score;
    }
  }
}

class _HomePageState extends State<HomePage> {
  static double birdYAxis = 0;
  double birdHeight = 0.15;
  double birdWidth = 0.15;
  // TOP
  double barrierXTop = 0;
  double barrierYTop = -1.1;
  double barrierWTop = 0.2;
  double barrierHTop = 0.6;
  // BOTTOM
  double barrierXBottom = 0;
  double barrierYBottom = 1.1;
  double barrierWBottom = 0.2;
  double barrierHBottom = 0.4;
  //Score
  Score record = new Score(0, 0);
  double time = 0;

  double initialHeight = birdYAxis;
  bool isGameStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  void startGame() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      double height = -4.9 * time * time + 2.8 * time; // (g*t^2)/2+v*t
      setState(() {
        birdYAxis = initialHeight - height;
        double speed = 0.1;
        barrierXBottom =
            barrierXBottom - speed < -1.0 ? 1.0 : barrierXBottom - speed;
        barrierXTop = barrierXTop - speed < -1.0 ? 1.0 : barrierXTop - speed;
      });
      stopGameWhen(timer);
      updateScore();
    });
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      if (!isGameStarted) {
        resetGame(timer);
      } else {
        Random r = new Random();
        setState(() {
          barrierHTop = 0.4 + 1.0 * r.nextDouble();
          barrierHBottom = 0.4 + 1.0 * r.nextDouble();
        });
      }
    });
  }

  void updateScore() {
    double birdXAxis = 0;
    double diffXTop = (birdXAxis - barrierXTop - barrierWTop).abs();
    double diffXBottom = (birdXAxis - barrierXBottom - barrierWBottom).abs();
    if (diffXTop <= 0.05 || diffXBottom <= 0.05) {
      record.updateScore();
    }
  }

  void stopGameWhen(Timer timer) {
    if (birdYAxis > 1) {
      resetGame(timer);
      return;
    }
    double birdXAxis = 0;
    if (barrierXTop - (barrierWTop / 2) <= birdXAxis &&
        birdXAxis <= barrierXTop + (barrierWTop / 2)) {
      if (birdYAxis <= barrierYTop + (barrierHTop / 2)) {
        resetGame(timer);
        return;
      }

      if (birdYAxis >= barrierYBottom - (barrierHBottom / 2)) {
        resetGame(timer);
        return;
      }
    }
  }

  void resetGame(Timer timer) {
    timer.cancel();
    setState(() {
      record.score = 0;
      isGameStarted = false;
      birdYAxis = 0;
      barrierYBottom = 1.1;
      barrierHBottom = 0.4;
      barrierYTop = -1.1;
      barrierHTop = 0.6;
      initialHeight = birdYAxis;
      time = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (isGameStarted) {jump()} else {startGame()}
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 3 / 4,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      child: Image.asset('lib/images/doge-stock.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    alignment: Alignment(0, 0.3),
                    child: isGameStarted
                        ? Text("")
                        : Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(0, birdYAxis),
                    duration: Duration(milliseconds: 0),
                    child: MyBird(
                      w: birdWidth,
                      h: birdHeight,
                    ),
                  ),
                  MyBarriers(
                    barrierX: barrierXTop,
                    barrierY: barrierYTop,
                    barrierWidth: barrierWTop,
                    barrierHeight: barrierHTop,
                  ),
                  MyBarriers(
                    barrierX: barrierXBottom,
                    barrierY: barrierYBottom,
                    barrierWidth: barrierWBottom,
                    barrierHeight: barrierHBottom,
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
                child: Container(
              color: Colors.brown,
              child: ScoreBoard(score: record.score, best: record.best),
            ))
          ],
        ),
      ),
    );
  }
}
