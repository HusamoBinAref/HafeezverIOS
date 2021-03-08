import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/book/set/model/data.dart';

class GetItemBooks {
  final Query query;

  GetItemBooks({@required this.query});

  Stream<ItemBooks> get stream => query.snapshots().map(ItemBooks.build);

  Widget widget(Widget Function(BuildContext context, ItemBooks books) builder) {
    return StreamBuilder<ItemBooks>(
      initialData: ItemBooks(list: []),
      stream: stream,
      builder: (context, booksSnapshot) {
        return builder(context, booksSnapshot.data);
      },
    );
  }
}
