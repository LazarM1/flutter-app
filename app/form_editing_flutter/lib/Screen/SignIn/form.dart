import 'package:flutter/material.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInForm createState() => _LogInForm();
}

class _LogInForm extends State<LogInForm> {
  final _LogInKey = GlobalKey<FormState>(); //unique id for Form
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.75,
        key: _LogInKey,
        child: Form(
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
                          return 'Enter Username';
                        }
                        return null;
                      },
                      style: TextStyle(
                        color: Colors.red,
                      ),
                      decoration: InputDecoration(
                          hintText: "Username",
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
                    onPressed: () {
                      if (_LogInKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Welcome')));
                      }
                    },
                    child: Text('LogIn'),
                  )),
            ],
          ),
        ));
  }
}
