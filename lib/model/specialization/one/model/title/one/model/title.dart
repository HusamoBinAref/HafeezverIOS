import 'package:cloud_firestore/cloud_firestore.dart';

class SpecializationTitle {
  static SpecializationTitle toTitle(DocumentSnapshot documentSnapshot) {
    return SpecializationTitle(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  static SpecializationTitle initialClass(
      String defaultLanguageCode, CollectionReference reference) {
    return SpecializationTitle(reference: reference.doc(defaultLanguageCode));
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;
  SpecializationTitle({
    this.map,
    this.reference, 
  });

  Map<String, dynamic> get _map => map ?? {};

  String get text => _map['text'] ?? '';
}
