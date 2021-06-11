import 'package:flutter/material.dart';

import 'Screen/Profile/code.dart';

final outline_button = OutlinedButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
  textStyle:
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  side: BorderSide(color: Colors.white, width: 3),
  shadowColor: Colors.black,
  elevation: 25,
);

final elevated_button = ElevatedButton.styleFrom(
  primary: Colors.blue,
  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  textStyle:
      TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
  shadowColor: Colors.black,
  elevation: 5,
);

final forgotten_password = TextStyle(fontSize: 18, color: Colors.blueAccent);

class InputField extends StatelessWidget {
  final String hintText;
  final String enterData;
  final IconData icon;
  final Color fill;
  final Color text;
  final bool obscure;
  final TextEditingController controller;
  const InputField({
    required this.hintText,
    required this.icon,
    required this.enterData,
    required this.fill,
    required this.text,
    required this.obscure,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        shadowColor: Colors.black,
        elevation: 3,
        child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return enterData;
              }
              return null;
            },
            obscureText: this.obscure,
            controller: this.controller,
            style: TextStyle(color: this.text, fontSize: 20),
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: Icon(this.icon),
                fillColor: fill,
                filled: true)));
  }
}

class DynamicInputField extends StatelessWidget {
  final Color fill;
  final Color text;
  final TextEditingController controller;

  final int index;
  const DynamicInputField({
    required this.fill,
    required this.text,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        shadowColor: Colors.black,
        elevation: 3,
        child: TextFormField(
            readOnly: !fieldsList[index].definition.isEditable,
            controller: controller,
            style: TextStyle(fontSize: 20),
            validator: (value) {
              RegExp regex = new RegExp(fieldsList[index].definition.regex);
              if (value!.isEmpty == true &&
                  fieldsList[index].definition.isRequired == true) {
                return 'Required';
              } else {
                if (!regex.hasMatch(value.toString())) {
                  return 'Enter valid ' + fieldsList[index].name;
                } else
                  return null;
              }
            },
            decoration: InputDecoration(
                fillColor: fill,
                labelText: fieldsList[index].definition.isRequired == true
                    ? (fieldsList[index].name + "*")
                    : (fieldsList[index].name),
                filled: true)));
  }
}
