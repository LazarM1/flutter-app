import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/SignIn/form.dart';
import 'package:form_editing_flutter/nav.dart';

class LogInScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(appBar: (Nav()), body: Center(child: LogInForm()));
  }
}
