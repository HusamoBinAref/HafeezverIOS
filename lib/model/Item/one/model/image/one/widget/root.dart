import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

class ItemImageWidgets {
  final ItemImage data;

  ItemImageWidgets({@required this.data});

  Widget image(
      {BoxFit fit,
      double width,
      double height,
      String placeHolderTag = PlaceHolderImages.itemImage}) {
    return CacheImageWidget(
      imageUrl: data.url,
      fit: fit,
      height: height,
      width: width,
      assetImageTag: placeHolderTag,
    );
  }

  Hero hero(
      {String extraTag = '',
      BoxFit fit,
      double width,
      double height,
      String placeHolderTag}) {
    return Hero(
      tag: data.reference.path + '/' + extraTag,
      child: image(
        fit: fit,
        height: height,
        width: width,
        placeHolderTag: placeHolderTag,
      ),
    );
  }
}
