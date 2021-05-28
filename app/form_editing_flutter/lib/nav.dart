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
            child: Center(
                child: Image.asset(
              'assets/images/logo.png',
            ))));
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
