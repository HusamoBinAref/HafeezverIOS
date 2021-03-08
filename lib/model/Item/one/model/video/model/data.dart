import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/video/widget/root.dart';

import 'package:intl/intl.dart';

class ItemVideo {
  static ItemVideo build(DocumentSnapshot documentSnapshot, {bool isPrimary = false}) {
    if (documentSnapshot != null && documentSnapshot.exists)
      return ItemVideo(
        map: documentSnapshot.data(),
        reference: documentSnapshot.reference,
      );
    else if (isPrimary)
      return ItemVideo();
    else
      return null;
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  ItemVideo({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {};
  String get url => _map['url'] ?? '';

  String get createString {
    var tempDate = (_map['createAt']as Timestamp).toDate();
    var format = DateFormat.yMMMMEEEEd(S.current.languageCode);
    return format.format(tempDate);
  }

  ItemVideoWidgets get widgets => ItemVideoWidgets(data: this);
}
