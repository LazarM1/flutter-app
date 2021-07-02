import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Register/register.dart';
import 'package:form_editing_flutter/Screen/SignIn/signin.dart';
import 'package:form_editing_flutter/nav.dart';
import 'package:form_editing_flutter/style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Nav(),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(AppLocalizations.of(context)!.welcome.toUpperCase(),
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: 250,
                    child: OutlinedButton(
                        style: outline_button,
                        onPressed: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInScreen()));
                          });
                        },
                        child: Text(AppLocalizations.of(context)!
                            .signIn
                            .toUpperCase()))),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: 250,
                    child: OutlinedButton(
                        style: outline_button,
                        onPressed: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          });
                        },
                        child: Text(AppLocalizations.of(context)!
                            .register
                            .toUpperCase()))),
              ],
            )),
      ),
    );
  }
}
