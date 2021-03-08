import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import '../model/email.dart';

class GetEmail {
  final DocumentReference reference;
  GetEmail({
    this.reference,
  });

  Stream<Email> get stream => reference.snapshots().map((_email) {
        if (_email.exists)
          return Email.toEmail(_email);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Email email) builder,
      {Widget child}) {
    return StreamBuilder<Email>(
        stream: stream,
        builder: (context, _email) {
          if (Check.asyncSnapshot(_email)) {
            return builder(context, _email.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
