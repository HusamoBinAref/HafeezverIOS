import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';

class ItemAudio {
  static ItemAudio build(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      return ItemAudio(reference: snapshot.reference, map: snapshot.data());
    } else
      return ItemAudio(
        reference: snapshot.reference,
      );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  ItemAudio({@required this.reference, this.map});

  Map<String, dynamic> get _map => map ?? {};

  String get url => _map['url'] ?? '';
}
