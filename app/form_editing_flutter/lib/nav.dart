import 'package:flutter/material.dart';
import 'l10n/widget.dart';

class Nav extends StatelessWidget implements PreferredSize {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppBar(
        actions: [
          LanguagePickerWidget(),
          const SizedBox(width: 12),
        ],
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
