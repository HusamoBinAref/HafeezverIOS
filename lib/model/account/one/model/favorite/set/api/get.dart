import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/favorite/set/model/data.dart';

class GetFavorites {
  static GetFavorites build(DocumentReference accountReference) {
    return GetFavorites(
        reference: accountReference.collection("Favorite").where("isFavorite", isEqualTo: true));
  }

  GetFavorites({@required this.reference});

  GetFavorites orderByData({bool descending = false}) {
    return GetFavorites(reference: reference.orderBy("createAt", descending: descending));
  }

  GetFavorites getByType({String type = ''}) {
    return type != '' ? GetFavorites(reference: reference.where("type", isEqualTo: type)) : this;
  }

  GetFavorites getByAccountFrom({DocumentReference accountReference}) {
    return accountReference != null
        ? GetFavorites(reference: reference.where("from", isEqualTo: accountReference.path))
        : this;
  }

  GetFavorites getByAccountTo({DocumentReference accountReference}) {
    return accountReference != null
        ? GetFavorites(reference: reference.where("to", isEqualTo: accountReference.path))
        : this;
  }

  final Query reference;

  Stream<Favorites> get stream => reference.snapshots().map(Favorites.build);

  Widget widget(Function(BuildContext context, Favorites favorites) builder) {
    return StreamBuilder<Favorites>(
        stream: stream,
        builder: (context, _favorites) {
          if (Check.asyncSnapshot(_favorites))
            return builder(context, _favorites.data);
          else
            return builder(context, Favorites(list: []));
        });
  }
}
