import 'package:flutter/material.dart';

class EmailForm extends StatefulWidget {
  @override
  _EmailForm createState() => _EmailForm();
}

class _EmailForm extends State<EmailForm> {
  final _EmailKey = GlobalKey<FormState>(); //unique id for Form

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width * 0.75,
        key: _EmailKey,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              Text('Become a member',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 15),
                      children: const <TextSpan>[
                    TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: ' Sign in',
                        style: TextStyle(color: Colors.blueAccent))
                  ])),
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
                          prefixIcon: Icon(Icons.email_outlined),
                          fillColor: Colors.white,
                          filled: true))),
              SizedBox(
                height: 25,
              ),
              Container(
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
                      if (_EmailKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Continue...')));
                      }
                    },
                    child: Text('Continue'),
                  )),
            ],
          ),
        ));
  }
}
