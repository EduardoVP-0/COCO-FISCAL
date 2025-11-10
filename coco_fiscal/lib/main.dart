import 'package:flutter/material.dart';
import 'screens/calendar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Fiscal',
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
      home: CalendarScreen(),
    );
  }
}
