import 'package:cloud_firestore/cloud_firestore.dart';

class Experience {
  static Experience toExperience(DocumentSnapshot document) {
    return Experience(
      map: document.data(),
      reference: document.reference,
    );
  }

  Experience({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  /// reference
  final DocumentReference reference;

  /// is public
  bool get isPublic => map['isPublic'] ?? false;
}
