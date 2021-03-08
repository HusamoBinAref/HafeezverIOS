import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/model/language/set/model/data.dart';

class GetLanguages {
  static GetLanguages build() {
    return GetLanguages(reference: FirestoreSelectors.languages);
  }

  /// * reference
  final Query reference;

  GetLanguages({
    @required this.reference,
  });
  Stream<Languages> get stream => reference.snapshots().map(Languages.build);

  Future<List<Language>> get future => reference.get().then(
        (languages) {
          if (languages.docs.isNotEmpty) {
            return languages.docs.map(Language.biuld).toList();
          } else {
            return <Language>[];
          }
        },
      );

  Widget widget(Function(BuildContext context, Languages languages) builder, {Widget child}) =>
      StreamBuilder<Languages>(
        stream: stream,
        builder: (context, langs) {
          if (Check.asyncSnapshot(langs)) {
            return builder(context, langs.data);
          } else {
            return builder(context, Languages(languages: []));
          }
        },
      );
}
