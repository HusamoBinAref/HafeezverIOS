import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';

class GetName {
  final DocumentReference reference;
  GetName({
    this.reference,
  });

  Stream<NameProfile> stream({bool isPrimary = false}) => reference.snapshots().map((_name) {
        if (_name.exists)
          return NameProfile.toName(_name);
        else if (isPrimary)
          return NameProfile(
            reference: reference,
          );
        return null;
      });

  Widget widget(
    Function(BuildContext context, NameProfile name) builder, {
    Widget child,
    bool isPrimary = false,
  }) {
    return StreamBuilder<NameProfile>(
        stream: stream(isPrimary: isPrimary),
        builder: (context, _name) {
          if (Check.asyncSnapshot(_name)) {
            return builder(context, _name.data);
          } else
            return builder(context, NameProfile(reference: reference));
        });
  }
}
