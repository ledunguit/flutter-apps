import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool started;

  CoverScreen({@required this.started});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, -0.2),
      child: Text(
        started ? '' : 'T A P T O P L A Y',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
