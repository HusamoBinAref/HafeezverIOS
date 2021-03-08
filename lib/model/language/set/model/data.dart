import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:hafeez/model/language/one/model/data.dart';

class Languages {
  static Languages build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty)
      return Languages(languages: snapshot.docs.map(Language.biuld).toList());
    else
      return Languages(languages: []);
  }

  final List<Language> languages;

  Languages({@required this.languages});

  List<Language> get selected => languages.where((element) => element.isSelected).toList();
}
