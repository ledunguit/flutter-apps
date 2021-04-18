import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Picker extends StatelessWidget {
  int qId;
  final Function(int id) pickerHander;

  Picker({@required this.qId, @required this.pickerHander});
  int limit(int x) {
    x = x < 1 ? x = 1 : x;
    x = x > 200 ? x = 200 : x;
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberPicker(
            value: qId,
            minValue: 1,
            maxValue: 200,
            step: 1,
            axis: Axis.horizontal,
            onChanged: (v) => pickerHander(v)),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(
              icon: Icon(
                Icons.remove_circle,
                size: 50,
              ),
              onPressed: () =>
                  {this.qId = limit(this.qId - 10), pickerHander(qId)}),
          SizedBox(
            width: 100,
          ),
          IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 50,
              ),
              onPressed: () =>
                  {this.qId = limit(this.qId + 10), pickerHander(qId)})
        ]),
      ],
    );
  }
}
