import 'package:intl/locale.dart';

class Titles {
  static String projectTitle(String localeCode) {
    if (localeCode == 'ar') {
      return 'منصة حفيظ';
    } else if (localeCode == 'en') {
      return 'Hafez Stage';
    } else if (localeCode == 'ru') {
      return 'платформа hafeez';
    } else if (localeCode == 'fr') {
      return 'plateforme hafeez';
    } else if (localeCode == 'es') {
      return 'Hafez Stage';
    } else if (localeCode == 'hi') {
      return 'हाफ़िज़ मंच';
    } else if (localeCode == 'pt') {
      return 'Hafez Stage';
    } else if (localeCode == 'zh') {
      return 'Hafez Stage';
    } else if (localeCode == 'de') {
      return 'Hafez Stage';
    } else
      return 'null';
  }

  static String language(String localeCode) {
    if (localeCode == 'ar') {
      return 'العربية';
    } else if (localeCode == 'en') {
      return 'English';
    } else if (localeCode == 'ru') {
      return 'روسية';
    } else if (localeCode == 'fr') {
      return 'فرنسية';
    } else if (localeCode == 'es') {
      return 'اسبانية';
    } else if (localeCode == 'hi') {
      return 'هندية';
    } else if (localeCode == 'pt') {
      return 'Hafez Stage';
    } else if (localeCode == 'zh') {
      return 'صينية';
    } else if (localeCode == 'de') {
      return 'المانية';
    } else
      return 'null';
  }

  String projectTitleByLocale({Locale localeCode}) {
    if (localeCode != null) {
      if (localeCode.languageCode == 'ar') {
        return 'منصة حفيظ';
      } else if (localeCode.languageCode == 'en') {
        return 'Hafez Stage';
      } else
        return 'null';
    } else {
      return 'منصة حفيظ';
    }
  }
}
