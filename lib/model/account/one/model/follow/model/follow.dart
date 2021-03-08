import 'package:cloud_firestore/cloud_firestore.dart';

class Follow {
  static Follow toFollow(DocumentSnapshot document) {
    return Follow(
      map: document.data(),
      reference: document.reference,
    );
  }

  Follow({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  /// reference
  final DocumentReference reference;

  /// email
  bool get email => map['isFollow'] ?? false;
}
