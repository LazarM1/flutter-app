import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';

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
        width: size.width * 0.75,
        child: Form(
          key: _LogInKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Sign in',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(
                height: 25,
              ),
              Material(
                  shadowColor: Colors.black,
                  elevation: 5,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                      controller: email,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          fillColor: Colors.white,
                          filled: true))),
              SizedBox(
                height: 25,
              ),
              Material(
                  elevation: 5,
                  shadowColor: Colors.black,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Password",
                          fillColor: Colors.white,
                          filled: true))),
              TextButton(
                onPressed: null,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 15,
                      color: Colors.blueAccent),
                ),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              SizedBox(
                  width: size.width * 0.75,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      shadowColor: Colors.black,
                      elevation: 5,
                    ),
                    onPressed: () async {
                      if (_LogInKey.currentState!.validate()) {
                        int code =
                            await _getHttpAnswer(email.text, password.text);
                        email.text = "";
                        password.text = "";
                        if (code == 200) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Invalid email/password')));
                        }
                      }
                    },
                    child: Text('LogIn'),
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
