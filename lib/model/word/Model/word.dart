import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/model/word/Model/title/api/title.dart';

class Word {
  static Word toWord(DocumentSnapshot documentSnapshot) {
    return Word(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  Word({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {};

  String get name => _map['name'] ?? '';

  String get defaultLanguageCode => _map['defaultLanguageCode'] ?? 'ar';

  bool isSelected = false;

  toggleSelection() {
    isSelected = !isSelected;
  }

  GetWordTitle get title => GetWordTitle.build(reference, defaultLanguageCode);
}
