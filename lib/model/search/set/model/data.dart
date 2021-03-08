import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/search/one/data.dart';

class SearchResults {
  static SearchResults build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty)
      return SearchResults(results: snapshot.docs.map(SearchResult.build).toList());
    else
      return SearchResults(results: []);
  }

  final List<SearchResult> results;

  SearchResults({@required this.results});
  List<SearchItemResult> get itemResults =>
      (results.where((result) => result.type == "Item").toList()).map(SearchItemResult.build).toList();
  List<SearchAccountResult> get userResults =>
      (results.where((result) => result.type == "User").toList()).map(SearchAccountResult.build).toList();
  List<SearchResult> get departmentResults => results.where((result) => result.type == "Department").toList();
}
