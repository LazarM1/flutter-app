import 'dart:developer';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Profile/edit.dart';
import 'package:form_editing_flutter/Screen/Register/form.dart';
import 'package:form_editing_flutter/nav.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../storage.dart';
import 'code.dart';

bool loaded = false;

class Profile extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: Nav(),
        body: Center(
            child: Container(
          width: size.width * 0.95,
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
                            icon: const Icon(Icons.create_outlined),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {
                              Future.delayed(Duration.zero, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit()));
                              });
                            }),
                      ))),
            ]),
            Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Container(
                    child: Align(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future: getFields(),
                      builder: (context, AsyncSnapshot<List<Field>> fields) {
                        switch (fields.connectionState) {
                          case ConnectionState.none:
                            return Text("Something went wrong");
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                          case ConnectionState.done:
                            return fields.hasData
                                ? ListView.builder(
                                    itemCount: fields.data!.length,
                                    itemBuilder: (context, index) {
                                      final profile = fields.data;
                                      return Card(
                                          elevation: 8.0,
                                          margin: new EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white12),
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                ),
                                                leading: Container(
                                                  padding: EdgeInsets.only(
                                                      right: 12.0),
                                                  decoration: new BoxDecoration(
                                                      border: new Border(
                                                          right: new BorderSide(
                                                              width: 1.0,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      51,
                                                                      45,
                                                                      45,
                                                                      45)))),
                                                  child: Icon(
                                                      Icons.circle_rounded,
                                                      color: Color.fromRGBO(
                                                          51, 45, 45, 45)),
                                                ),
                                                title: Text(
                                                  profile![index].value,
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 19),
                                                ),
                                                subtitle: Row(
                                                  children: <Widget>[
                                                    Text(profile![index].name,
                                                        style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    51,
                                                                    45,
                                                                    45,
                                                                    45),
                                                            fontSize: 16))
                                                  ],
                                                ),
                                              )));
                                    },
                                  )
                                : const CircularProgressIndicator();
                        }
                      }),
                )))
          ]),
        )));
  }
}
