import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Register/form.dart';
import 'package:form_editing_flutter/nav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';

class Profile extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Nav(),
        body: Center(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            textStyle: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            shadowColor: Colors.black,
            elevation: 5,
          ),
          onPressed: () async {
            _getProfile();
          },
          child: Text('Test'),
        )));
  }
}

class Field {
  final String name;
  final String value;

  Field({
    required this.name,
    required this.value,
  });
}

Future<int> _getProfile() async {
  final token = await secureStorage.read('token');
  final url = Uri.parse(
      'https://loyaltyprime.loyaltyprime.kividev.si/desktopmodules/loyaltyprime.wl.web.ui/api/Profile/GetUserProfile');

  final headers = {
    "Authorization": "Bearer $token",
    "Content-type": "application/json"
  };
  final response = await http.get(url, headers: headers);
  log(response.statusCode.toString());
  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body)['data'];
    log(res.toString());
    return response.statusCode;
  } else {
    return response.statusCode;
  }
}
