import 'package:cloud_firestore/cloud_firestore.dart';

class Followed {
  static Followed toFollowed(DocumentSnapshot documentSnapshot) {
    return Followed(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  Followed({
    this.reference,
    this.map,
  });

  DocumentReference get followerReference =>
      (map['followerReference'] ?? '' as DocumentReference);

  DocumentReference get followedReference =>
      (map['followedReference'] ?? '' as DocumentReference);
}
