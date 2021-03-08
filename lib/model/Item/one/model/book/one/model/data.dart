import 'package:cloud_firestore/cloud_firestore.dart';

class ItemBook {
  static ItemBook build(DocumentSnapshot snapshot) {
    if (snapshot.exists)
      return ItemBook(snapshot: snapshot);
    else
      return ItemBook(inputReference: snapshot.reference);
  }

  final DocumentReference inputReference;
  final DocumentSnapshot snapshot;

  ItemBook({this.inputReference, this.snapshot});

  bool get isNotNull => snapshot != null;

  DocumentReference get reference => isNotNull ? snapshot.reference : inputReference;
  Map<String, dynamic> get _map => isNotNull ? snapshot.data() ?? {} : {};

  String get url => _map["url"] ?? "";
}
