import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/model/account/one/api/get.dart';

class Friend {
  final DocumentReference reference;
  final Map<String, dynamic> map;
  Friend({this.reference, this.map});

  static Friend toFriend(DocumentSnapshot documentSnapshot) {
    return Friend(
        reference: documentSnapshot.reference, map: documentSnapshot.data());
  }

  static DocumentReference toReference(DocumentSnapshot documentSnapshot) {
    return documentSnapshot.reference;
  }

  DocumentReference get friendReference =>
      (map['friendReference'] as DocumentReference);

  GetAccount get account => GetAccount(
        reference: friendReference,
      );
}
