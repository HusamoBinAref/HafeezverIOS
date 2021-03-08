import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';

class ModifyItemTitle {
  final ItemTitle title;

  ModifyItemTitle({
    @required this.title,
  });

  Future<void> setData(BuildContext context) async {
    await title.reference.set(
      {"text": title.controller.value.text},
      SetOptions(merge: true),
    ).then((value) => title.text = title.controller.value.text);
  }
}
