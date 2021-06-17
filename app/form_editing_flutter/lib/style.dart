import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Profile/edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final bool obscure;
  final TextEditingController controller;
  const InputField({
    required this.hintText,
    required this.icon,
    required this.enterData,
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
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon:
                    Icon(this.icon, color: Theme.of(context).primaryColor),
                filled: true)));
  }
}

class DynamicInputField extends StatelessWidget {
  final Color text;
  final TextEditingController controller;

  final int index;
  const DynamicInputField({
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
            style: TextStyle(fontSize: 18),
            validator: (value) {
              RegExp regex = new RegExp(fieldsList[index].definition.regex);
              if (value!.isEmpty == true &&
                  fieldsList[index].definition.isRequired == true) {
                return AppLocalizations.of(context)!.required;
              } else {
                if (!regex.hasMatch(value.toString())) {
                  return AppLocalizations.of(context)!.invalidInput;
                } else
                  return null;
              }
            },
            decoration: InputDecoration(
                labelText: fieldsList[index].definition.isRequired == true
                    ? (Name(AppLocalizations.of(context)!.localeName,
                            fieldsList[index].name) +
                        "*")
                    : (Name(AppLocalizations.of(context)!.localeName,
                        fieldsList[index].name)),
                filled: true)));
  }
}
