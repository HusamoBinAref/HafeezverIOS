import 'package:cloud_firestore/cloud_firestore.dart';

class Nationality {
  static Nationality toNationality(DocumentSnapshot document) {
    return Nationality(
      map: document.data(),
      reference: document.reference,
    );
  }

  static Nationality getDefault(DocumentReference reference) {
    return Nationality(
      map: {'first': 'insert 1 ...', 'second': 'insert 2 ...', 'third': 'insert 3 ...', 'isPublic': false},
      reference: reference,
    );
  }

  Nationality({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  /// reference
  final DocumentReference reference;

  /// First nationality
  // DocumentReference get firstNationality =>
  //     map['first'] as DocumentReference ?? null;
  String get firstNationality => map['first'] ?? '';

  /// second nationality
  // DocumentReference get secondNationality =>
  //     map['second'] as DocumentReference ?? null;
  String get secondNationality => map['second'] ?? '';

  /// third nationality
  // DocumentReference get thirdNationality =>
  //     map['third'] as DocumentReference ?? null;
  String get thirdNationality => map['third'] ?? '';

  /// is public
  bool get isPublic => map['isPublic'] ?? false;
}
