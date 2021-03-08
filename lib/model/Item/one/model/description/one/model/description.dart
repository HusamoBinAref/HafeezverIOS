import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/description/one/api/modify.dart';
import 'package:hafeez/model/Item/one/model/description/one/widget/root.dart';

class ItemDescription {
  static ItemDescription toDescription(DocumentSnapshot documentSnapshot) {
    return ItemDescription(
      map: documentSnapshot.data(),
      reference: documentSnapshot.reference,
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  ItemDescription({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {};

  String get text => _map['text'] ?? '';

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  refreshController() => _controller = TextEditingController(text: text);

  ModifyItemDescription get modify => ModifyItemDescription(description: this);
  ItemDescriptionWidgets get widgets => ItemDescriptionWidgets(description: this);
}
