import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/api/modify.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/widget/root.dart';

class NameProfile {
  static NameProfile toName(DocumentSnapshot document) {
    return NameProfile(
      map: document.data(),
      reference: document.reference,
    );
  }

  NameProfile({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;

  Map<String, dynamic> get _map => map ?? {};

  /// reference
  final DocumentReference reference;

  /// descriptoin
  String get text => _map['text'] ?? '';

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  refreshController() => _controller = TextEditingController(text: text);

  NameProfileWidgets get widgets => NameProfileWidgets(data: this);
  ModifyNameProfile get modify => ModifyNameProfile(data: this);
}
