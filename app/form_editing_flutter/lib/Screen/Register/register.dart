import 'package:flutter/material.dart';
import 'package:form_editing_flutter/nav.dart';

class Register extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Nav(),
      body: EmailForm(),
    );
  }
}

class EmailForm extends StatefulWidget {
  @override
  _EmailForm createState() => _EmailForm();
}

class _EmailForm extends State<EmailForm> {
  final _EmailKey = GlobalKey<FormState>(); //unique id for Form

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _EmailKey,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 25,
              ),
              TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ))),
              SizedBox(
                height: 25,
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
