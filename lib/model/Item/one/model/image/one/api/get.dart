import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show
        AssetImage,
        BuildContext,
        Center,
        FutureBuilder,
        Hero,
        Image,
        StreamBuilder,
        Widget,
        BoxFit;

import '../../../../../../../classes/tools/check.dart';
import '../../../../../../../widget/containers.dart';
import '../model/image.dart';

class GetItemImage {
  final DocumentReference reference;
  GetItemImage({
    this.reference,
  });

  Stream<ItemImage> get stream {
    return reference.snapshots().map((_itemTitle) {
      if (_itemTitle.exists)
        return ItemImage.toImage(_itemTitle);
      else
        return ItemImage(reference: reference);
    });
  }

  Widget widget(
    Function(BuildContext context, ItemImage itemImage) builder,
  ) {
    return StreamBuilder<ItemImage>(
        stream: stream,
        builder: (context, _itemImage) {
          if (Check.asyncSnapshot(_itemImage))
            return builder(context, _itemImage.data);
          else
            return Center(child: Containers.waitting(context));
        });
  }

  Future<ItemImage> get future {
    return reference.get().then((_itemTitle) {
      if (_itemTitle.exists)
        return ItemImage.toImage(_itemTitle);
      else
        return ItemImage(
          reference: _itemTitle.reference,
        );
    });
  }

  Widget widgetFuture(
      Function(BuildContext context, ItemImage itemImage) builder,
      {Widget child}) {
    return FutureBuilder<ItemImage>(
        initialData: ItemImage(reference: reference),
        future: future,
        builder: (context, _itemImage) {
          if (Check.asyncSnapshot(_itemImage)) {
            return builder(context, _itemImage.data);
          } else {
            return Hero(
              tag: this.reference.path,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/default/placeholder.png"),
              ),
            );
          }
        });
  }
}
