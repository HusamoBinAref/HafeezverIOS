import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import '../model/phone.dart';

class GetPhone {
  final DocumentReference reference;
  GetPhone({
    this.reference,
  });

  Stream<Phone> get stream => reference.snapshots().map((_phone) {
        if (_phone.exists)
          return Phone.toPhone(_phone);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Phone phone) builder,
      {Widget child}) {
    return StreamBuilder<Phone>(
        stream: stream,
        builder: (context, _phone) {
          if (Check.asyncSnapshot(_phone)) {
            return builder(context, _phone.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
