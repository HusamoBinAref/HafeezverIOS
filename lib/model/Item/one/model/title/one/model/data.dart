import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hafeez/model/Item/one/model/title/one/api/modify.dart';
import 'package:hafeez/model/Item/one/model/title/one/widget/all.dart';

class ItemTitle {
  static ItemTitle toTitle(DocumentSnapshot documentSnapshot) {
    return ItemTitle(
      map: documentSnapshot.data(),
      reference: documentSnapshot.reference,
    );
  }

  final DocumentReference reference;

  final Map<String, dynamic> map;

  ItemTitle({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {"text": ""};

  String get text => _map['text'] ?? "";
  set text(String text) => _map['text'] = text;

  bool get checkIsOwner => (FirebaseAuth.instance.currentUser != null &&
      reference // title
              .parent
              .parent // item
              .parent
              .parent // user
              .id ==
          FirebaseAuth.instance.currentUser.uid);

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  refreshController() => _controller = TextEditingController(text: text);

  ModifyItemTitle get modify => ModifyItemTitle(title: this);
  ItemTitleWidgets get widgets => ItemTitleWidgets(title: this);
}
