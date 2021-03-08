import 'package:cloud_firestore/cloud_firestore.dart';

class Email {
  static Email toEmail(DocumentSnapshot document) {
    return Email(
      map: document.data(),
      reference: document.reference,
    );
  }

  Email({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  /// reference
  final DocumentReference reference;

  /// email
  String get email => map['text'] ?? '';
}
