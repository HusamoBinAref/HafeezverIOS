import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/search/set/model/item_data.dart';

class GetItemsByTitle {
  static GetItemsByTitle build({
    @required String title,
    int count = 20,
  }) {
    return GetItemsByTitle(
        reference: FirestoreSelectors.titles
            .where("text", isGreaterThanOrEqualTo: title)
            .where("text", isLessThanOrEqualTo: title + "ي")
            // .where("text", arrayContains: [title])
            .limit(count));
  }

  final Query reference;

  GetItemsByTitle({@required this.reference});

  Stream<SearchResultsItemsByTitle> get stream =>
      reference.snapshots().map(SearchResultsItemsByTitle.build);

  Future<SearchResultsItemsByTitle> get futur =>
      reference.get().then(SearchResultsItemsByTitle.build);

  Widget widget(
      Widget Function(BuildContext context,
              AsyncSnapshot<SearchResultsItemsByTitle> asyncResultsItemsByTitle)
          builder) {
    return StreamBuilder<SearchResultsItemsByTitle>(
      // initialData: SearchResultsItemsByTitle(snapshot: null),
      stream: stream,
      builder: (context, _result) {
        if (_result.hasData)
          return builder(context, _result);
        else
          return Container();
      },
    );
  }

  Widget futureWidget(
      Widget Function(BuildContext context,
              AsyncSnapshot<SearchResultsItemsByTitle> asyncResultsItemsByTitle)
          builder) {
    return FutureBuilder<SearchResultsItemsByTitle>(
        future: futur,
        builder: (context, asyncSnap) {
          if (asyncSnap.hasData)
            return builder(context, asyncSnap);
          else
            return Container();
        });
  }
}
