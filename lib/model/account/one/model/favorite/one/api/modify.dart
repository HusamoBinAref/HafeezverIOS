import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/account/one/model/favorite/one/model/data.dart';

class ModifyFavorite {
  final Favorite data;

  ModifyFavorite({@required this.data});

  Future setData() async {
    await data.reference.set({
      "isFavorite": !data.isFavorite,
      "to": data.to,
      "from": data.from,
      "type": data.type,
      "createAt": Timestamp.now(),
    }, SetOptions(merge: true));
  }
}
