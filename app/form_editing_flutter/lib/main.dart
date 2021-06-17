import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Screen/Welcome/welcome.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'provider.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      builder: (context, child) {
        final provider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
          locale: provider.locale,
          supportedLocales: L10n.all,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          themeMode: ThemeMode.system,
          theme: CustomTheme.lightTheme,
          darkTheme: CustomTheme.darkTheme,
          home: MyHomePage(),
        );
      });
}

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: Color.fromRGBO(51, 45, 45, 1),
        accentColor: Color.fromRGBO(51, 45, 45, 1),
        scaffoldBackgroundColor: Color(0xfff1f2f2),
        fontFamily: 'Montserrat', //3

        inputDecorationTheme: InputDecorationTheme(fillColor: Colors.white));
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.black,
      fontFamily: 'Montserrat',
      textTheme: ThemeData.dark().textTheme,
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.black87, hintStyle: TextStyle(color: Colors.white)),
    );
  }
}
