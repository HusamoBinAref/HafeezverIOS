import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/favorite/one/model/data.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';

class GetFavorite {
  final DocumentReference reference;
  final DocumentReference toReference;
  final DocumentReference fromReference;
  final String type;
  GetFavorite({
    @required this.reference,
    this.toReference,
    this.fromReference,
    this.type,
  });

  static GetFavorite buildForItem({@required DocumentReference reference, @required String type}) {
    return GetFavorite(
      reference: Favorite.createReference(itemReference: reference),
      fromReference: GetAuthentication().currentUserReference,
      toReference: reference,
      type: type,
    );
  }

  static GetFavorite buildForAccount({@required DocumentReference reference, @required String type}) {
    return GetFavorite(
      reference: Favorite.createReferenceForAccount(favoriteReference: reference),
      fromReference: GetAuthentication().currentUserReference,
      toReference: reference,
      type: type,
    );
  }

  Stream<Favorite> get stream {
    return reference.snapshots().map((favoirte) {
      if (favoirte.exists)
        return Favorite.build(favoirte);
      else
        return Favorite(reference: reference, map: {
          "to": toReference,
          "from": fromReference,
          "type": type,
        });
    });
  }

  Widget widget({@required Function(BuildContext context, Favorite favorite) builder}) {
    return StreamBuilder<Favorite>(
        stream: stream,
        builder: (context, _favorite) {
          if (Check.asyncSnapshot(_favorite))
            return builder(context, _favorite.data);
          else
            return builder(
                context,
                Favorite(reference: reference, map: {
                  "to": toReference,
                  "from": fromReference,
                  "type": type,
                }));
        });
  }
}
