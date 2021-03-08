import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, DocumentSnapshot;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';

import 'package:hafeez/model/Item/one/model/data.dart';

class GetItem {
  static GetItem toGetItem(DocumentSnapshot documentSnapshot) {
    return GetItem(reference: documentSnapshot.reference.parent.parent);
  }

  final DocumentReference reference;
  GetItem({
    this.reference,
  });

  Stream<ITem> get stream => reference.snapshots().map((_descriptoin) {
        if (_descriptoin.exists)
          return ITem.toItem(_descriptoin);
        else
          return ITem(reference: reference);
      });

  Widget widget(Function(BuildContext context, ITem iTem) builder, {Widget child}) {
    return StreamBuilder<ITem>(
        stream: stream,
        builder: (context, _iTem) {
          if (Check.asyncSnapshot(_iTem)) {
            return builder(context, _iTem.data);
          } else
            return child == null ? Container() : child;
        });
  }
}


