import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Profile/profile.dart';
import 'package:form_editing_flutter/Screen/Register/form.dart';
import 'package:form_editing_flutter/nav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';
import 'code.dart';
import 'package:form_editing_flutter/style.dart';

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

class _Edit extends State<Edit> {
  final _updateKey = GlobalKey<FormState>();
  final controller = Create(); //unique id for Form
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: Nav(),
        body: Center(
            child: Container(
                width: size.width * 0.85,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  Stack(children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(Icons.account_circle_outlined,
                          color: Colors.blueGrey, size: 150),
                    ),
                    Align(
                        child: Padding(
                            padding: EdgeInsets.only(top: 100, left: 45),
                            child: Container(
                                decoration: new BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(40.0)),
                                child: IconButton(
                                    icon: const Icon(Icons.check),
                                    color: Colors.white,
                                    iconSize: 30,
                                    onPressed: () async {
                                      if (_updateKey.currentState!.validate()) {
                                        int code =
                                            await _getUpdateAnswer(controller);
                                        if (code != 200) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Something went wrong...')));
                                        } else {
                                          Future.delayed(Duration.zero, () {
                                            Navigator.pop(context);
                                          });
                                        }
                                      }
                                    }))))
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
                                                    child: DynamicInputField(
                                                        controller:
                                                            controller[index],
                                                        text: Colors.black,
                                                        index: index,
                                                        fill: Colors.white)));
                                          })),
                                ]),
                              ))))
                ]))));
  }
}

Future<int> _getUpdateAnswer(List<TextEditingController> text) async {
  final token = await secureStorage.read('token');
  Map<String, String> data = new Map();
  for (int i = 0; i < fieldsList.length; i++) {
    data[fieldsList[i].name] = text[i].text;
  }
  final url = Uri.parse(
      'https://loyaltyprime.loyaltyprime.kividev.si/desktopmodules/loyaltyprime.wl.web.ui/api/Profile/UpdateUserProfile');
  final headers = {
    "Authorization": "Bearer $token",
    "Content-type": "application/json"
  };
  final json = jsonEncode(data);
  final response = await http.post(url, headers: headers, body: json);
  log(json);
  log(response.statusCode.toString());

  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}
