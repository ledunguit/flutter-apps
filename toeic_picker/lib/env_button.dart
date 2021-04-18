import 'package:flutter/material.dart';

class EnvButton extends StatelessWidget {
  final bool isSelected;
  final Function(bool) selectHandler;
  final String env;

  EnvButton(
      {@required this.isSelected,
      @required this.selectHandler,
      @required this.env});

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(this.env, style: TextStyle(fontSize: 20)),
      value: isSelected,
      onChanged: selectHandler,
      activeTrackColor: Colors.yellow,
      activeColor: Colors.green,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
    );
  }
}
