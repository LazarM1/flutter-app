import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Register/register.dart';
import 'package:form_editing_flutter/Screen/SignIn/signin.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      primary: Colors.white,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      textStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      side: BorderSide(color: Colors.white, width: 3),
      shadowColor: Colors.black,
      elevation: 25,
    );
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              SizedBox(
                  width: 250,
                  child: OutlinedButton(
                      style: style,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()));
                      },
                      child: Text("LOGIN"))),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                  width: 250,
                  child: OutlinedButton(
                      style: style,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Text("REGISTER"))),
            ],
          ),
        ),
      ),
    );
  }
}
