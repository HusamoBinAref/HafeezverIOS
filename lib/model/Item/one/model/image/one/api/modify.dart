import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';

class ModifyItemImage {
  final ItemImage data;

  ModifyItemImage({@required this.data});

  Future setData(BuildContext context, String url) async {
    return await data.reference.set({"url": url});
  }
}
