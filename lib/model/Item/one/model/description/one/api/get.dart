import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';

class GetItemDescription {
  final DocumentReference reference;

  GetItemDescription({
    @required this.reference,
  });

  Stream<ItemDescription> get stream {
    return reference.snapshots().map((_stream) {
      if (_stream.exists)
        return ItemDescription(reference: _stream.reference, map: _stream.data());
      else
        return ItemDescription(
          reference: reference,
        );
    });
  }

  Widget widget(Function(BuildContext context, ItemDescription description) builder) {
    return StreamBuilder<ItemDescription>(
      stream: stream,
      builder: (context, _description) {
        if (Check.asyncSnapshot(_description))
          return builder(context, _description.data);
        else
          return builder(context, ItemDescription(reference: reference));
      },
    );
  }
}
