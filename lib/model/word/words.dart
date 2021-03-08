import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, Query;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Divider,
        ListTile,
        ListView,
        StreamBuilder,
        Text,
        Widget;

import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/word/set/model/data.dart';

import 'Model/word.dart';

class GetWords {
  static GetWords get build {
    return GetWords(reference: FirestoreSelectors.words);
  }

  static const double maxRowHeight = 30;

  static GetWords get buildOrderByDate {
    return build.byDate();
  }

  final Query reference;

  GetWords({
    @required this.reference,
  });

  /// * order by create date
  GetWords byDate({bool isDescending = false}) => GetWords(
        reference: isDescending
            ? reference.orderBy('createAt', descending: true)
            : reference.orderBy('createAt'),
      );

  Stream<Words> get stream {
    return reference.snapshots().map(Words.build);
  }

  Future<List<Word>> get future {
    return reference.get().then(
      (_words) {
        if (_words.docs.isNotEmpty) {
          return _words.docs.map(Word.toWord).toList();
        } else
          return <Word>[];
      },
    );
  }

  Future<Words> futureFun(List<DocumentReference> list) {
    return reference.get().then(
      (_words) {
        if (_words.docs.isNotEmpty) {
          var futureList = _words.docs.map((word) {
            var wordModel = Word.toWord(word);
            wordModel.isSelected = list.contains(wordModel.reference);

            return wordModel;
          }).toList();

          return Words(words: futureList);
        } else
          return Words(words: []);
      },
    );
  }

  Widget widget(
    Function(BuildContext context, Words words) builder, {
    Widget child,
  }) {
    return StreamBuilder<Words>(
      stream: stream,
      builder: (context, wordsSnap) {
        if (Check.asyncSnapshot(wordsSnap)) {
          return builder(context, wordsSnap.data);
        } else
          return builder(context, Words(words: []));
      },
    );
  }

  Widget get list {
    return widget((context, words) {
      words.words.removeWhere((word) => word.reference.id.contains('public'));

      return ListView.separated(
        itemCount: words.words.length,
        cacheExtent: 10,
        itemBuilder: (context, index) {
          var word = words.words[index];
          return word.title.widget(
            builder: (context, title) => Card(
              child: ListTile(
                title: Text(title.text),
                onTap: () {},
              ),
            ),
          );
        },
        separatorBuilder: (_, i) {
          return Divider();
        },
      );
    });
  }
}
