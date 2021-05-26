import 'package:flutter/material.dart';
import 'package:form_editing_flutter/nav.dart';

class LogInScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(appBar: (Nav()), body: LogInForm());
  }
}

class LogInForm extends StatefulWidget {
  @override
  _LogInForm createState() => _LogInForm();
}

class _LogInForm extends State<LogInForm> {
  final _LogInKey = GlobalKey<FormState>(); //unique id for Form
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _LogInKey,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Username",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ))),
              SizedBox(
                height: 25,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ))),
              TextButton(
                onPressed: null,
                child: Text('Forgot Password?'),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
              SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
