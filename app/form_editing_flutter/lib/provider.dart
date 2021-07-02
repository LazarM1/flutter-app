import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'storage.dart';

import 'l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  final String defaultLocale = Platform.localeName;

  Locale _locale = new Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = Locale('en');

    notifyListeners();
  }

  Locale getDeafult() {
    switch (defaultLocale) {
      case "sl_SI":
        return new Locale('sl');

      default:
        return new Locale('en');
    }
  }
}
