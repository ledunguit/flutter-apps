import 'package:flutter/material.dart';

class MyBarriers extends StatelessWidget {
  final barrierX;
  final barrierY;
  final barrierWidth;
  final barrierHeight;

  MyBarriers(
      {this.barrierX, this.barrierY, this.barrierWidth, this.barrierHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(barrierX, barrierY),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(
              width: 10,
              color: Colors.yellow.shade300,
            )),
        width: MediaQuery.of(context).size.width * barrierWidth / 2,
        height: MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2,
      ),
    );
  }
}
