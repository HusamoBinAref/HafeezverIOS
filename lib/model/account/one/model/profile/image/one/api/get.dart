import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/widget/containers.dart';

class GetImageProfile {
  final DocumentReference reference;
  GetImageProfile({
    this.reference,
  });

  Stream<ImageProfile> get stream {
    return reference.snapshots().map((_itemTitle) {
      if (_itemTitle.exists)
        return ImageProfile.toImageProfile(_itemTitle);
      else
        return ImageProfile(reference: reference);
    });
  }

  Widget widget(
    Function(BuildContext context, ImageProfile itemImage) builder,
  ) {
    return StreamBuilder<ImageProfile>(
        // initialData: ImageProfile(reference: reference),
        stream: stream,
        builder: (context, _itemImage) {
          if (Check.asyncSnapshot(_itemImage))
            return builder(context, _itemImage.data);
          else
            // return builder(context, ImageProfile(reference: reference));
            return Center(
                child: Center(child: Containers.waitting(context)));
        });
  }

  Future<ImageProfile> get future {
    return reference.get().then((_itemTitle) {
      if (_itemTitle.exists)
        return ImageProfile.toImageProfile(_itemTitle);
      else
        return ImageProfile(
          reference: _itemTitle.reference,
        );
    });
  }

  Widget widgetFuture(
      Function(BuildContext context, ImageProfile itemImage) builder,
      {Widget child}) {
    return FutureBuilder<ImageProfile>(
        initialData: ImageProfile(reference: reference),
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
