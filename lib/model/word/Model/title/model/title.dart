import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/generated/l10n.dart';

class WordTitle {
  static WordTitle toTitle(DocumentSnapshot documentSnapshot) {
    return WordTitle(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }
 
  static WordTitle initialClass(String defaultLanguageCode, CollectionReference reference) {
    return WordTitle(reference: reference.doc(S.current.languageCode));
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;
  WordTitle({
    this.map,
    this.reference,
  });
  Map<String, dynamic> get _map => map ?? {};

  String get text => _map['text'] ?? '';
}
