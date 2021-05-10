import 'package:flutter/material.dart';

class AlarmWidget extends StatefulWidget {
  @override
  _AlarmWidgetState createState() => _AlarmWidgetState();
}

class _AlarmWidgetState extends State<AlarmWidget> {
  bool _isTurnedOff = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed:
        _toggleTurnedOff,
        // setState(() {
        //   // do something here
        // });
        icon: (_isTurnedOff ? Icon(Icons.alarm_on) : Icon(Icons.alarm_off))
    );
  }

  void _toggleTurnedOff() {
    setState(() {
      if (_isTurnedOff) {
        _isTurnedOff = false;
      } else {
        _isTurnedOff = true;
      }
    });
  }
}
