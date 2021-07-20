import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final score;
  final best;

  ScoreBoard({@required this.score, @required this.best});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SCORE",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(score.toString(),
                style: TextStyle(color: Colors.white, fontSize: 35))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BEST", style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 20),
            Text(best.toString(),
                style: TextStyle(color: Colors.white, fontSize: 35))
          ],
        )
      ],
    );
  }
}
