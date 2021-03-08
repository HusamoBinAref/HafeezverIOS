import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/language/one/model/data.dart';

class GetLanguage {
  final DocumentReference reference;

  GetLanguage({this.reference});

  Stream<Language> get stream => reference.snapshots().map(Language.biuld);
  Future<Language> get future => reference.get().then(Language.biuld);

  Widget widget(Function(BuildContext context, Language language) builder) {
    return StreamBuilder<Language>(
        stream: stream,
        builder: (context, _language) {
          if (Check.asyncSnapshot(_language)) {
            return builder(context, _language.data);
          } else
            return Container();
        });
  }

  Widget materialLanguage(
    Function(BuildContext context, Language language) builder, {
    Language defaultLanguage,
  }) {
    return StreamBuilder<Language>(
        stream: stream,
        builder: (context, _language) {
          if (Check.asyncSnapshot(_language)) {
            return builder(context, _language.data);
          } else
            return builder(context, defaultLanguage);
        });
  }
}
