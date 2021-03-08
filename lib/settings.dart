import 'package:flutter/material.dart' show Locale, ValueNotifier;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

ValueNotifier<Locale> mobileLanguage = new ValueNotifier(null);

class Configrations {
  static Future<void> changeLanguage(String languageCode) async {
    mobileLanguage.value = new Locale(languageCode);
    await setDefaultLanguage(languageCode);

    mobileLanguage.notifyListeners();
  }

  static Future<void> setDefaultLanguage(String language) async {
    if (language != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', language);
    }
  }

  static Future<ValueNotifier<Locale>> get getDefaultLanguage async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('language')) {
      mobileLanguage = ValueNotifier(Locale(prefs.get('language'), ''));
    }
    return mobileLanguage;
  }
}
