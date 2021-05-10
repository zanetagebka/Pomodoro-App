import 'package:flutter/material.dart';
import 'package:layout_learning/alarm_toggler.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaySoundWidget extends StatefulWidget {
  @override
  _PlaySoundState createState() => _PlaySoundState();
}

class _PlaySoundState extends State<PlaySoundWidget> {
  final player = AudioCache();
  bool _isAlarmOn = true;

  @override
  Widget build(BuildContext context) {
    _playNoise;
  }

  void _playNoise() {
    setState(() {
      if(_isAlarmOn) {
        player.play("audio/alarm.wav");
      } else {

      }
    });
  }
}