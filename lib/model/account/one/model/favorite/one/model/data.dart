import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/account/one/model/favorite/one/api/modify.dart';
import 'package:hafeez/model/account/one/model/favorite/one/widget/root.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';

class Favorite {
  static Favorite build(DocumentSnapshot snapshot) {
    return Favorite(reference: snapshot.reference, map: snapshot.data());
  }

  /// create favorite reference depend on current user
  /// by give it [itemReference] and return Document reference for the document favorite
  static DocumentReference createReference({@required DocumentReference itemReference}) {
    var userReference = GetAuthentication().currentUserReference;
    if (userReference != null) return userReference.collection("Favorite").doc(itemReference.parent.parent.id + itemReference.id);

    return null;
  }

  static DocumentReference createReferenceForAccount({@required DocumentReference favoriteReference}) {
    var userReference = GetAuthentication().currentUserReference;
    if (userReference != null) return userReference.collection("Favorite").doc(favoriteReference.id);

    return null;
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  Favorite({@required this.reference, this.map});
  Map<String, dynamic> get _map => map ?? {};

  DocumentReference get to => _map['to'] as DocumentReference ?? null;
  DocumentReference get from => _map['from'] as DocumentReference ?? null;
  bool get isFavorite => _map['isFavorite'] ?? false;
  String get type => _map['type'] ?? '';

  FavoriteWidgets get widgets => FavoriteWidgets(data: this);
  ModifyFavorite get modify => ModifyFavorite(data: this);
}
