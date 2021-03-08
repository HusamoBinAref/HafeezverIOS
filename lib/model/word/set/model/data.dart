import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:hafeez/model/word/Model/word.dart';
import 'package:hafeez/model/word/set/widget/root.dart';

class Words {
  static Words build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty)
      return Words(words: snapshot.docs.map(Word.toWord).toList());
    else
      return Words(words: []);
  }

  final List<Word> words;

  Words({@required this.words});

  WordsWidgets get widgets => WordsWidgets(data: this);
  List<Word> get selected => words.where((element) => element.isSelected).toList();
}
