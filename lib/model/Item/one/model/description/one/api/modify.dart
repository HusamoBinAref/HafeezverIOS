import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';

class ModifyItemDescription {
  final ItemDescription description;

  ModifyItemDescription({
    @required this.description,
  });

  Future<void> setData(BuildContext context) async {
    await description.reference.set(
      {"text": description.controller.value.text},
      SetOptions(merge: true),
    );
  }
}
