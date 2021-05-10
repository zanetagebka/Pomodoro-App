import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:layout_learning/countdown_timer.dart';
import 'package:layout_learning/utils/constants.dart';
import 'package:ndialog/ndialog.dart';
import 'package:layout_learning/alarm_toggler.dart';

class HomePage extends StatefulWidget {
  final List<Icon> timesCompleted = [];

  HomePage() {
    // Initialize times completed dot icons
    for (var i = 0; i < 3; i++) {
      timesCompleted.add(
        Icon(
          Icons.brightness_1_rounded,
          color: Colors.yellow,
          size: 5.0,
        ),
      );
    }
  }

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  final CountDownController _clockController = CountDownController();
  Icon _clockButton = kPlayClockButton; // Initial value
  bool _isClockStarted = false; // Conditional flag
  bool _isClockRestarted = false;

  // Change Clock button icon and controller
  void switchClockActionButton() {
    if (_clockButton == kPlayClockButton) {
      _clockButton = kPauseClockButton;

      if (!_isClockStarted && !_isClockRestarted) {
        // Processed on init
        _isClockStarted = true;
        _clockController.start();
      } else {
        // Processed on play
        _clockController.resume();
      }
    } else {
      // Processed on pause
      _clockButton = kPlayClockButton;
      _clockController.pause();
    }
  }

  void restartClockForShortBreak() {
    _clockController.restart(duration: kShortBreakDuration);
  }

  void restartClockForWork() {
    _clockController.restart();
    _clockButton = kPlayClockButton;
  }

  @override
  Widget build(BuildContext context) {
    // Half Screen Dimensions
    final double height = MediaQuery.of(context).size.height / 2;
    final double width = MediaQuery.of(context).size.width / 2;
    int indexTimesCompleted = 0;

    CountDownTimer _countDownTimer = CountDownTimer(
      duration: kWorkDuration,
      fillColor: Colors.white,
      onComplete: () {
        setState(() async {
          widget.timesCompleted[indexTimesCompleted] = Icon(
            Icons.brightness_1_rounded,
            color: Colors.white,
            size: 5.0,
          );
          indexTimesCompleted++;
          await NDialog(
            dialogStyle: DialogStyle(titleDivider: true),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Done"),
                  TextButton(
                    child: Icon(Icons.close),
                    onPressed: () {
                      restartClockForWork();
                      _clockController.pause();
                      Navigator.pop(context);
                    },
                  )
                ]),
            content: Text("What next?"),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.green),
                  ),
                  child: Text("Start short break"),
                  onPressed: () {
                    restartClockForShortBreak();
                    Navigator.pop(context);
                  }),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red),
                  ),
                  child: Text("Back to work"),
                  onPressed: () {
                    restartClockForWork();
                    Navigator.pop(context);
                  }),
            ],
          ).show(context);
        });
      },
    );

    CircularCountDownTimer clock = CircularCountDownTimer(
      controller: _clockController,
      isReverseAnimation: false,
      ringColor: Colors.red,
      height: height,
      width: width,
      autoStart: false,
      duration: _countDownTimer.duration * 60,
      isReverse: true,
      textStyle: TextStyle(color: Colors.white, fontSize: 30.0),
      fillColor: _countDownTimer.fillColor,
      backgroundColor: Color(0xFF2A2B4D),
      strokeCap: StrokeCap.round,
      onComplete: _countDownTimer.onComplete,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Pomodoro App'),
        centerTitle: true,
        actions: [
          AlarmWidget()
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Center(
                child: clock,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      switchClockActionButton();
                    });
                  },
                  child: Container(
                    width: width / 2.5,
                    height: height / 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _clockButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

