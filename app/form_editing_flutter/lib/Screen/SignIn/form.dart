import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/ForgottenPassword/forgotten.dart';
import 'package:form_editing_flutter/Screen/Home/home.dart';
import 'package:form_editing_flutter/Screen/Register/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';
import 'package:form_editing_flutter/style.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInForm createState() => _LogInForm();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _LogInForm extends State<LogInForm> {
  final _LogInKey = GlobalKey<FormState>(); //unique id for Form
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.85,
        child: Form(
          key: _LogInKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'SIGN IN',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Color.fromRGBO(51, 45, 45, 1)),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            style: TextStyle(fontSize: 18),
                            children: const <TextSpan>[
                          TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(color: Colors.black))
                        ])),
                    TextButton(
                        onPressed: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          });
                        },
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(fontSize: 18),
                                children: const <TextSpan>[
                              TextSpan(
                                  text: 'Register now',
                                  style: TextStyle(color: Colors.blueAccent))
                            ])))
                  ]),
              Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: InputField(
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      enterData: 'Enter Email',
                      fill: Colors.white,
                      text: Colors.black,
                      obscure: false,
                      controller: email)),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: InputField(
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    enterData: 'Enter Password',
                    fill: Colors.white,
                    text: Colors.black,
                    obscure: true,
                    controller: password),
              ),
              TextButton(
                onPressed: () {
                  Future.delayed(Duration.zero, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Forgotten()));
                  });
                },
                child: Text('Forgot Password?', style: forgotten_password),
              ),
              SizedBox(
                  width: size.width * 0.85,
                  child: ElevatedButton(
                    style: elevated_button,
                    onPressed: () async {
                      if (_LogInKey.currentState!.validate()) {
                        int code =
                            await _getHttpAnswer(email.text, password.text);
                        email.text = "";
                        password.text = "";
                        if (code == 200) {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid email/password')));
                        }
                      }
                    },
                    child: Text('LOGIN'),
                  )),
            ],
          ),
        ));
  }
}

Future<int> _getHttpAnswer(var e, var p) async {
  final prefix = '0_';
  final email = prefix + e;
  final pass = p;
  final url = Uri.parse(
      'https://loyaltyprime.loyaltyprime.kividev.si/DesktopModules/JwtAuth/API/mobile/login');
  final headers = {"Content-type": "application/json"};
  final json = jsonEncode(<String, String>{'u': email, 'p': pass});
  final response = await http.post(url, headers: headers, body: json);
  log(json);
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    await secureStorage.write('token', res['accessToken'] as String);
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}
