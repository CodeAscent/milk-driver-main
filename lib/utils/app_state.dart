import 'package:flutter/material.dart';
import '../model/language_item.dart';
import '../model/setting_data.dart';

AppState appState = AppState();

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();
 ValueNotifier<SettingData> setting =  ValueNotifier(SettingData());
   Map<String, dynamic> languageKeys = <String, dynamic>{};
   LanguageItem languageItem = LanguageItem(languageCode: 'en',languageName: 'English');
   ValueNotifier<String> currentLanguageCode = ValueNotifier("en");
}