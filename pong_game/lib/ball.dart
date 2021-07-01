import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final x;
  final y;

  MyBall({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(this.x, this.y),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.yellow,
        ),
        width: 20,
        height: 20,
      ),
    );
  }
}
