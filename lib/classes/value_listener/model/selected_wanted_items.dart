import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:hafeez/classes/commends/key_words.dart';

class SelectedWantedItems with ChangeNotifier {
  Map<String, bool> _selections = {
    KeyWords.sheikh: true,
    KeyWords.department: true,
    KeyWords.itemKeyWords[0]: true,
    KeyWords.itemKeyWords[1]: true,
    KeyWords.itemKeyWords[2]: true,
    KeyWords.itemKeyWords[3]: true,
  };

  toggleSelection(String selectionName) {
    _selections[selectionName] = !_selections[selectionName];
    this.notifyListeners();
  }

  bool isSelected({String selectionName}) =>
      _selections[selectionName] ?? false;

  bool get showAll => (_selections[KeyWords.itemKeyWords[0]] ||
      _selections[KeyWords.itemKeyWords[1]] ||
      _selections[KeyWords.itemKeyWords[2]] ||
      _selections[KeyWords.itemKeyWords[3]]);
}

class ItemsSelector {
  static String sheikh = 'Sheikh';
  static String department = 'department';
  static String book = KeyWords.itemKeyWords[0];
  static String post = KeyWords.itemKeyWords[2];
  static String video = KeyWords.itemKeyWords[3];
  static String voice = KeyWords.itemKeyWords[1];
}
