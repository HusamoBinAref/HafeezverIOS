import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';

class ModifyDescriptionProfile {
  final DescriptionProfile data;

  ModifyDescriptionProfile({@required this.data});

  setData(BuildContext context) async {
    await data.reference.set({"text": data.controller.value.text}, SetOptions(merge: true));
  }
}
