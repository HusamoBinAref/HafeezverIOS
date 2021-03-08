import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/follow/model/follow.dart';

class GetFollow {
  final DocumentReference reference;
  GetFollow({
    this.reference,
  });

  Stream<Follow> get stream => reference.snapshots().map((_follow) {
        if (_follow.exists)
          return Follow.toFollow(_follow);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Follow follow) builder,
      {Widget child}) {
    return StreamBuilder<Follow>(
        stream: stream,
        builder: (context, _follow) {
          if (Check.asyncSnapshot(_follow)) {
            return builder(context, _follow.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
