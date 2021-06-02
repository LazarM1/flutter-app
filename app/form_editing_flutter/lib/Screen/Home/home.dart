import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Profile/profile.dart';
import 'package:form_editing_flutter/Screen/Welcome/welcome.dart';
import 'package:form_editing_flutter/nav.dart';
import '../../storage.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25);
    return Scaffold(
        appBar: Nav(),
        body: Container(
          child: Center(
              child: Text("WELCOME",
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54))),
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(50),
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  title: Text(
                    'Profile',
                    style: style,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
                  title: Text('LogOut', style: style),
                  onTap: () {
                    secureStorage.delete('token');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  title: 'MyHomePage',
                                )));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
