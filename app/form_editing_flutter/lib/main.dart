import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screen/Welcome/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfff1f2f2),
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurpleAccent,
      ),
      home: MyHomePage(),
    );
  }
}
