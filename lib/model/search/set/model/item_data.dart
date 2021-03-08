import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/search/one/model/item_data.dart';

class SearchResultsItemsByTitle {
  SearchResultsItemsByTitle({@required this.snapshot});

  static SearchResultsItemsByTitle build(QuerySnapshot snapshot) {
    return SearchResultsItemsByTitle(snapshot: snapshot);
  }

  final QuerySnapshot snapshot;

  static SearchResultsItemsByTitle get empty => SearchResultsItemsByTitle(snapshot: null);

  bool get isNotNull => snapshot != null;

  List<SearchResultItemByTitle> get list => isNotNull
      ? snapshot.docs.where((element) => element.reference.path.contains("Item")).map(SearchResultItemByTitle.build).toList()
      : [];
}
