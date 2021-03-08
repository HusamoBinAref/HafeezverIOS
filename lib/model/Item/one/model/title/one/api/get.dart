import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class GetItemTitle {
  final DocumentReference reference;

  GetItemTitle({
    @required this.reference,
  });

  Stream<ItemTitle> get stream {
    return reference.snapshots().map((_stream) {
      if (_stream.exists)
        return ItemTitle(reference: _stream.reference, map: _stream.data());
      else
        return ItemTitle(
          reference: reference,
        );
    });
  }

  Widget widget(Function(BuildContext context, ItemTitle title) builder) {
    return StreamBuilder<ItemTitle>(
      stream: stream,
      builder: (context, _title) {
        if (Check.asyncSnapshot(_title))
          return builder(context, _title.data);
        else
          // return builder(context, ItemTitle(reference: reference));
          return Center(child: Containers.waitting(context));
      },
    );
  }
}
