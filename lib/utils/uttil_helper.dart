import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_state.dart';

class UtilsHelper {
  UtilsHelper._();
  static const List<String> rightHandLang = [
    //TODO: add more Right to Left languages
    'ar', // Arabic
    'fa', // Farsi
    'he', // Hebrew
    'ps', // Pashto
    'ur', // Urdu
  ];

  static const String wr_default_font_family = 'Helvetica';
  static const String the_sans_font_family = 'TheSans';

  // static String getString(context, String key) {
  //   if (key != '' && appState.languageKeys.containsKey(key)) {
  //     return appState.languageKeys[key];
  //   } else if (key != '') {
  //     print("$key NOT AVAILABLE");
  //     return key;
  //   } else {
  //     return '';
  //   }
  // }

  static Future<void> loadLocalization(String languageCode) async {
    String jsonString =
        await rootBundle.loadString('asset/translations/$languageCode.json');
    Map<String, dynamic> languageKeys = json.decode(jsonString);
    appState.languageKeys = languageKeys;
  }

  static String getString(BuildContext? context, String key) {
    if (key.isNotEmpty && appState.languageKeys.containsKey(key)) {
      return appState.languageKeys[key];
    } else {
      return key;
    }
  }
}
