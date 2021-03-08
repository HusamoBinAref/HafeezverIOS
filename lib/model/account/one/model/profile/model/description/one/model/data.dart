import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/api/modify.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/widget/root.dart';

class DescriptionProfile {
  static DescriptionProfile toDescriptoin(DocumentSnapshot document) {
    return DescriptionProfile(
      map: document.data(),
      reference: document.reference,
    );
  }

  DescriptionProfile({
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

  /// is public
  bool get isPublic => _map['isPublic'] ?? false;

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;
  refreshController() => _controller = TextEditingController(text: text);

  DescriptionProfileWidgets get widgets => DescriptionProfileWidgets(data: this);
  ModifyDescriptionProfile get modify => ModifyDescriptionProfile(data: this);
}
