// import 'package:cloud_firestore/cloud_firestore.dart';

// class Language {
//   static Language toLanguage(DocumentSnapshot document) {
//     return Language(
//       map: document.data(),
//       reference: document.reference,
//     );
//   }

//   Language({
//     this.map = const {
//       'languageId': 'arabic',
//       'languageCode': 'ar',
//     },
//     this.reference,
//   });

//   /// data
//   final Map<String, dynamic> map;

//   /// reference
//   final DocumentReference reference;

//   /// name
//   String get languageId => map['languageId'] ?? 'arabic';
//   String get languageCode => map['languageCode'] ?? 'ar';
// }
