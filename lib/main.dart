import 'package:flutter/material.dart';
import 'package:layout_learning/home_page.dart';

void main() => runApp(Pomodoro());

class Pomodoro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF2A2B4D),
        primaryColor: Colors.redAccent,
      ),
      home: HomePage(),
    );
  }
}