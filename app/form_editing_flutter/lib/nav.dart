import 'package:flutter/material.dart';

class Nav extends StatelessWidget implements PreferredSize {
  Widget build(BuildContext context) {
    return AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo.png',
                      width: 55.0, height: 55.0)
                ])));
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
