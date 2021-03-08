import 'package:cloud_firestore/cloud_firestore.dart';

class Skill {
  static Skill toSkill(DocumentSnapshot document) {
    return Skill(
      map: document.data(),
      reference: document.reference,
    );
  }

  Skill({
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
