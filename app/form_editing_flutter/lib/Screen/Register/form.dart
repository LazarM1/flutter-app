import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/SignIn/form.dart';
import 'package:form_editing_flutter/Screen/SignIn/signin.dart';
import 'package:form_editing_flutter/style.dart';

class EmailForm extends StatefulWidget {
  @override
  _EmailForm createState() => _EmailForm();
}

TextEditingController email_register = new TextEditingController();

class _EmailForm extends State<EmailForm> {
  final _EmailKey = GlobalKey<FormState>(); //unique id for Form

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width * 0.85,
        child: Form(
          key: _EmailKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text('BECOME A MEMBER',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(51, 45, 45, 1)))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 18),
                          children: const <TextSpan>[
                        TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(color: Colors.black))
                      ])),
                  TextButton(
                      onPressed: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LogInScreen()));
                        });
                      },
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 18),
                              children: const <TextSpan>[
                            TextSpan(
                                text: ' Sign in',
                                style: TextStyle(color: Colors.blueAccent))
                          ]))),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: InputField(
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      enterData: 'Enter Email',
                      fill: Colors.white,
                      text: Colors.black,
                      obscure: false,
                      controller: email_register)),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                      width: size.width * 0.85,
                      child: ElevatedButton(
                        style: elevated_button,
                        onPressed: () {
                          if (_EmailKey.currentState!.validate()) {
                            email_register.text = "";
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Continue...')));
                          }
                        },
                        child: Text('CONTINUE'),
                      ))),
            ],
          ),
        ));
  }
}
