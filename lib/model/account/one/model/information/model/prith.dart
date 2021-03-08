import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hafeez/generated/l10n.dart';
import 'package:intl/intl.dart';

class Prith {
  static Prith toPrith(DocumentSnapshot infoSnap) {
    return Prith(
      map: infoSnap.data(),
      reference: infoSnap.reference,
    );
  }

  Prith({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  /// reference
  final DocumentReference reference;

  /// prith Location
  String get prithLocation => map['location'] ?? '';



  DateTime get prithDate => (map['date']as Timestamp).toDate();

  String get prithDateString {
    if (map['date'] != null) {
      var format = DateFormat.yMMMMEEEEd(S.current.languageCode);
      return format.format(prithDate);
    } else {
      return '';
    }
  }

  /// is public
  bool get isPublic => map['isPublic'] ?? false;
}
