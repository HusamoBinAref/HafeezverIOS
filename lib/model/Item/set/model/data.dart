import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/set/widget/root.dart';

class Items {
  static Items build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty)
      return Items(list: snapshot.docs.map(ITem.toItem).toList());
    else
      return Items(list: []);
  }

  static Items get empty {
    return Items(list: []);
  }

  final List<ITem> list;

  Items({@required this.list});

  Items getByType(String type) {
    return Items(list: list.where((item) => item.type == type).toList());
  }

  ItemsWidgets get widgets => ItemsWidgets(items: this);
}

class ItemsByMonths {
  final Items items;

  ItemsByMonths({
    @required this.items,
  });

  List<ITem> get list => items.list;
  DateTime get firstItemDate => list.first.createAt;
  DateTime get lastItemDate => list.last.createAt;
  int get itemsDifferenceDays => lastItemDate.difference(firstItemDate).inDays;
  getFirstAndLast() {
    print(firstItemDate.toString());
    print(lastItemDate.toString());
  }
}
