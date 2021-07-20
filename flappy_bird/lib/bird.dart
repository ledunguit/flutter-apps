import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final w;
  final h;

  MyBird({this.w, this.h});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 4 * h,
      width: MediaQuery.of(context).size.width * w,
      child: Image.asset('lib/images/doge.png'),
    );
  }
}
