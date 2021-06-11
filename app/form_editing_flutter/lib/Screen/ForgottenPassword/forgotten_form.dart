import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/SignIn/form.dart';
import 'package:form_editing_flutter/Screen/SignIn/signin.dart';
import 'package:form_editing_flutter/style.dart';

class ForgottenForm extends StatefulWidget {
  @override
  _ForgottenForm createState() => _ForgottenForm();
}

TextEditingController forgotten_pass = new TextEditingController();

class _ForgottenForm extends State<ForgottenForm> {
  final _ForgottenKey = GlobalKey<FormState>(); //unique id for Form

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width * 0.85,
        child: Form(
          key: _ForgottenKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text('FORGOT PASSWORD?',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(51, 45, 45, 1)))),
              Padding(
                  padding: EdgeInsetsDirectional.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: 18),
                              children: const <TextSpan>[
                            TextSpan(
                                text: 'Don’t worry, happens to the best of us.',
                                style: TextStyle(color: Colors.black))
                          ])),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: InputField(
                      hintText: 'Please enter your e-mail',
                      icon: Icons.email_outlined,
                      enterData: 'Enter Email',
                      fill: Colors.white,
                      text: Colors.black,
                      obscure: false,
                      controller: forgotten_pass)),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Container(
                      width: size.width * 0.85,
                      child: ElevatedButton(
                        style: elevated_button,
                        onPressed: () {
                          if (_ForgottenKey.currentState!.validate()) {
                            forgotten_pass.text = "";
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Continue...')));
                          }
                        },
                        child: Text('EMAIL ME A RECOVERY LINK'),
                      ))),
            ],
          ),
        ));
  }
}
