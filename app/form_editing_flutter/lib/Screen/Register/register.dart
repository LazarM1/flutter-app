import 'package:flutter/material.dart';
import 'package:form_editing_flutter/Screen/Register/form.dart';
import 'package:form_editing_flutter/nav.dart';

class Register extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Nav(),
      body: Center(child: EmailForm()),
    );
  }
}
