import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';

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
//lista objekata polja npr (ime:required,enabled, regex...)
    List<Definition> data = [];
    asd.forEach((element) {
      data.add(Definition.fromJson(element));
    });

    return data;
  } else {
    return null;
  }
}

//Klasa sa definicijama polja profila koje povlacimo iz api ja
class Definition {
  late String propertyName;
  late bool isEditable;
  late bool isRequired;
  late String propertyType;
  late String codeRegisterId;
  late String regex;

  Definition(this.propertyName, this.isEditable, this.isRequired,
      this.propertyType, this.codeRegisterId, this.regex);

//citanje iz jsona i ubacivanje u objekat
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

var fieldsList = [];

//Ime polja(FirsName), value (Lazar),definition objekat(definicija polja)
class Field {
  late final String name;
  late final String value;
  late Definition definition;
  String get def {
    return name;
  }

  Field(this.name, this.value);
}

//lista svih polja sa definicijom i sa podacima korisnika
Future<List<Field>> getFields() async {
  final data = await _getProfile();
  final definition = await _getProfileDefinition();
  var fields = <Field>[];
  //lista definicija, dodajemo na filed objekat  objekat definicije
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

// http reques dobijamo podatke profila
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
///saljemo request

// ignore: non_constant_identifier_names

//po jezicima lokalizacija dinamicnih polja
String Name(String lan, String name) {
  if (lan == "sl") {
    switch (name) {
      case "FirstName":
        return "Ime";
      case "LastName":
        return "Priimek";
      case "Address1":
        return "Naslov";
      case "City":
        return "Mesto";
      case "Zip":
        return "Poštna številka";
      case "State":
        return "Država";
      case "EmailAddress":
        return "E-naslov";
    }
  }
  return name;
}
