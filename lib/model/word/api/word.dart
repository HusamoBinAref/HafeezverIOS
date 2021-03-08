import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';

import 'package:hafeez/model/word/Model/word.dart';

class GetWord {
  final DocumentReference reference;
  GetWord({
    this.reference,
  });

  Stream<Word> get stream => reference.snapshots().map((_word) {
        if (_word.exists)
          return Word.toWord(_word);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Word word) builder,
      {Widget child}) {
    return StreamBuilder<Word>(
        stream: stream,
        builder: (context, _word) {
          if (Check.asyncSnapshot(_word)) {
            return builder(context, _word.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
