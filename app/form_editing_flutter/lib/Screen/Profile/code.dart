import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Register/form.dart';
import 'package:form_editing_flutter/nav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';

var fieldsList = [];

class Field {
  late final String name;
  late final String value;
  late Definition definition;
  Field(this.name, this.value);
}

Future<List<Field>> getFields() async {
  final data = await _getProfile();
  final definition = await _getProfileDefinition();
  var fields = <Field>[];
  if (data != null) {
    data.forEach((k, v) => fields.add(new Field(k, v)));
  }
  if (fields != null && definition != null) {
    for (int i = 0; i < fields.length; i++) {
      fields[i].definition = definition[i];
    }
  }
  fieldsList = fields;
  return fields;
}

/////////////////
Future<Map<String, dynamic>?> _getProfile() async {
  final token = await secureStorage.read('token');
  final url = Uri.parse(
      'https://loyaltyprime.loyaltyprime.kividev.si/desktopmodules/loyaltyprime.wl.web.ui/api/Profile/GetUserProfile');

  final headers = {
    "Authorization": "Bearer $token",
    "Content-type": "application/json"
  };
  final response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body)["data"];
    return res;
  } else {
    return null;
  }
}

/////////////////
///
Future<List<Definition>?> _getProfileDefinition() async {
  final token = await secureStorage.read('token');
  final url = Uri.parse(
      'https://loyaltyprime.loyaltyprime.kividev.si/desktopmodules/loyaltyprime.wl.web.ui/api/Profile/GetProfileDefinition');

  final headers = {
    "Authorization": "Bearer $token",
    "Content-type": "application/json"
  };
  final response = await http.get(url, headers: headers);
  if (response.statusCode == 200) {
    List asd = json.decode(response.body)["data"];

    List<Definition> data = [];
    asd.forEach((element) {
      data.add(Definition.fromJson(element));
    });

    return data;
  } else {
    return null;
  }
}

class Definition {
  late String propertyName;
  late bool isEditable;
  late bool isRequired;
  late String propertyType;
  late String codeRegisterId;
  late String regex;

  Definition(this.propertyName, this.isEditable, this.isRequired,
      this.propertyType, this.codeRegisterId, this.regex);

  Definition.fromJson(Map<String, dynamic> json) {
    propertyName = json['propertyName'];
    isEditable = json['isEditable'];
    isRequired = json['isRequired'];
    propertyType = json['propertyType'];
    codeRegisterId = json['codeRegisterId'];
    regex = json['regex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propertyName'] = this.propertyName;
    data['isEditable'] = this.isEditable;
    data['isRequired'] = this.isRequired;
    data['propertyType'] = this.propertyType;
    data['codeRegisterId'] = this.codeRegisterId;
    data['regex'] = this.regex;
    return data;
  }
}
