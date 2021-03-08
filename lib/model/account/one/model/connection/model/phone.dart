import 'package:cloud_firestore/cloud_firestore.dart';

class Phone {
  static Phone toPhone(DocumentSnapshot document) {
    return Phone(
      map: document.data(),
      reference: document.reference,
    );
  }

  Phone({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  /// reference
  final DocumentReference reference;

  /// name
  String get phone => map['phone'] ?? '...';

  /// is public
  bool get isPublic => map['isPublic'] ?? false;
}
