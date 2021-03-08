import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/word/Model/title/model/title.dart';

class GetWordTitle {
  static GetWordTitle build(DocumentReference reference, String defaultLanguageCode) =>
      GetWordTitle(
          reference: reference.collection('Title'), defaultLanguageCode: defaultLanguageCode);

  final CollectionReference reference;
  final String defaultLanguageCode;
  GetWordTitle({this.reference, this.defaultLanguageCode = 'ar'});

  Stream<WordTitle> get stream => reference
      .doc(S.current.languageCode)
      .snapshots()
      .map((word) => word.exists ? WordTitle.toTitle(word) : null);

  Stream<WordTitle> get streamDefault =>
      reference.doc(defaultLanguageCode).snapshots().map((word) => word.exists
          ? WordTitle.toTitle(word)
          : WordTitle(reference: reference.doc(S.current.languageCode)));

  Widget widget(
      {@required Function(BuildContext context, WordTitle title) builder,
      bool isPrimary = false,
      Widget child}) {
    return StreamBuilder<WordTitle>(
        stream: stream,
        builder: (context, _title) {
          if (Check.asyncSnapshot(_title))
            return builder(context, _title.data);
          else
            return StreamBuilder<WordTitle>(
                stream: streamDefault,
                builder: (context, _titleDefault) {
                  if (Check.asyncSnapshot(_titleDefault))
                    return builder(context, _titleDefault.data);
                  else
                    return isPrimary
                        ? builder(
                            context, WordTitle.initialClass(S.current.languageCode, reference))
                        : child != null
                            ? child
                            : Container();
                });
        });
  }
}
