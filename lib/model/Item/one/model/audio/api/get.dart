import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/Item/one/model/audio/model/data.dart';

class GetItemAudio {
  static GetItemAudio buildByItem(
      DocumentReference itemReference, String languageCode) {
    return GetItemAudio(
        reference: FirestoreSelectors.itemAudios(itemReference).doc("ar"));
  }

  final DocumentReference reference;

  GetItemAudio({@required this.reference});

  Stream<ItemAudio> get stream => reference.snapshots().map(ItemAudio.build);

  Widget widget(Function(BuildContext context, ItemAudio itemAudio) builder) {
    return StreamBuilder<ItemAudio>(
        stream: stream,
        builder: (context, _audio) {
          if (Check.asyncSnapshot(_audio))
            return builder(context, _audio.data);
          else {
            return Container();
          }
        });
  }
}
