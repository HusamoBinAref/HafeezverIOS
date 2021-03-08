import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/model/Item/one/model/image/one/api/modify.dart';
import 'package:hafeez/model/Item/one/model/image/one/widget/root.dart';

class ItemImage {
  static ItemImage toImage(DocumentSnapshot documentSnapshot) {
    return ItemImage(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  ItemImage({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {};
  String get url => _map['url'] ?? '';

  ItemImageWidgets get widgets => ItemImageWidgets(data: this);
  ModifyItemImage get modify => ModifyItemImage(data: this);
}
