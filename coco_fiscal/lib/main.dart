import 'package:flutter/material.dart';
import 'Form_crear_cuenta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Fiscal',
      theme: ThemeData(primarySwatch: Colors.green),
      home: CrearCuentaScreen(),
    );
  }
}
