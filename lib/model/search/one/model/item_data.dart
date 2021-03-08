import 'package:cloud_firestore/cloud_firestore.dart';

class SearchResultItemByTitle {
  static SearchResultItemByTitle build(QueryDocumentSnapshot snapshot) {
    if (snapshot.exists)
      return SearchResultItemByTitle(snapshot: snapshot);
    else {
      return SearchResultItemByTitle(inputReference: snapshot.reference);
    }
  }

  final QueryDocumentSnapshot snapshot;
  final DocumentReference inputReference;

  SearchResultItemByTitle({this.inputReference, this.snapshot});

  bool get isNotNull => snapshot != null;
  DocumentReference get reference => isNotNull ? snapshot.reference : inputReference;
  Map<String, dynamic> get map => isNotNull ? snapshot.data() ?? {} : {};
  String get text => map['text'] ?? "";
}
