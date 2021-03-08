import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';

class KeyWords {
  static const String account = "Account";
  static const String sheikh = "Sheikh";
  static const String department = "Department";
  static const String specailization = "Specailization";
  static const String books = "Book";
  static const String posts = "Post";
  static const String videos = "Video";
  static const String voices = "Voice";
  static const List<String> itemKeyWords = const <String>[
    books,
    posts,
    videos,
    voices,
  ];

  static const String isSheikh = "isSheikh";
  static const String isAccount = "isAccount";

  static String convert(BuildContext context, String word) {
    if (word == posts) {
      return S.of(context).posts;
    } else if (word == books) {
      return S.of(context).books;
    } else if (word == videos) {
      return S.of(context).videos;
    } else if (word == voices) {
      return S.of(context).voices;
    } else
      return "";
  }
}

class CheckFunctions {
  static bool isItem(String type) {
    return KeyWords.itemKeyWords.contains(type);
  }

  static bool isAccount(String type) {
    return type == KeyWords.isSheikh || type == KeyWords.isAccount;
  }
}
