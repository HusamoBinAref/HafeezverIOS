import 'package:cloud_firestore/cloud_firestore.dart';
import '../../one/model/data.dart';

class ItemBooks {
  static ItemBooks build(QuerySnapshot snapshot) {
    return ItemBooks(list: snapshot.docs.map(ItemBook.build).toList());
  }

  final List<ItemBook> list;

  ItemBooks({this.list});
}
