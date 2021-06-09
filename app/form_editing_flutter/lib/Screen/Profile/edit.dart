import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Register/form.dart';
import 'package:form_editing_flutter/nav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';
import 'code.dart';

List<TextEditingController> Create() {
  List<TextEditingController> text = [];
  for (int i = 0; i < fieldsList.length; i++) {
    text.add(new TextEditingController());
    text[i].text = fieldsList[i].value;
    log(fieldsList[i].definition.propertyName);
    log(fieldsList[i].definition.regex);
  }
  return text;
}

class Edit extends StatefulWidget {
  @override
  _Edit createState() => _Edit();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _Edit extends State<Edit> {
  final _updateKey = GlobalKey<FormState>();
  final controller = Create(); //unique id for Form
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: Nav(),
        body: Center(
            child: Container(
                width: size.width * 0.75,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.account_circle_outlined,
                          color: Colors.blueAccent, size: 150),
                    ),
                    Align(
                        child: Padding(
                      padding: EdgeInsets.only(top: 100, left: 45),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(40.0)),
                      ),
                    )),
                  ]),
                  Flexible(
                      flex: 3,
                      fit: FlexFit.loose,
                      child: Container(
                          child: Align(
                              alignment: Alignment.center,
                              child: Form(
                                key: _updateKey,
                                child: Column(children: <Widget>[
                                  Flexible(
                                      child: ListView.builder(
                                          itemCount: fieldsList.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Material(
                                                        shadowColor:
                                                            Colors.black,
                                                        elevation: 5,
                                                        child: TextFormField(
                                                            readOnly:
                                                                !fieldsList[index]
                                                                    .definition
                                                                    .isEditable,
                                                            controller:
                                                                controller[
                                                                    index],
                                                            validator: (value) {
                                                              RegExp regex = new RegExp(
                                                                  fieldsList[
                                                                          index]
                                                                      .definition
                                                                      .regex);
                                                              if (!regex
                                                                  .hasMatch(value
                                                                      .toString())) {
                                                                return 'Enter valid ' +
                                                                    fieldsList[
                                                                            index]
                                                                        .name;
                                                              } else if (value!
                                                                          .isEmpty ==
                                                                      true &&
                                                                  fieldsList[index]
                                                                          .definition
                                                                          .isRequired ==
                                                                      true) {
                                                                return 'Required';
                                                              } else
                                                                return null;
                                                            },
                                                            decoration: InputDecoration(
                                                                hintText:
                                                                    fieldsList[
                                                                            index]
                                                                        .name,
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                filled:
                                                                    true)))));
                                          })),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      shadowColor: Colors.black,
                                      elevation: 5,
                                    ),
                                    onPressed: () {
                                      if (_updateKey.currentState!.validate()) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text('Updated')));
                                      }
                                    },
                                    child: Text('Update'),
                                  )
                                ]),
                              ))))
                ]))));
  }
}
