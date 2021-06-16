import 'package:flutter/material.dart';

class L10n {
  static final all = [const Locale('en'), const Locale('sl')];

  static String getFlag(String code) {
    switch (code) {
      case 'sl':
        return 'SLO';
      case 'en':
      default:
        return 'EN';
    }
  }
}
