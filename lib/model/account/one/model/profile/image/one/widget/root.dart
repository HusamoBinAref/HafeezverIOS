import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';

import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';

import 'package:hafeez/widget/cache_image_widgets.dart';

class AccountImageWidgets {
  final ImageProfile data;

  AccountImageWidgets({@required this.data});

  Widget image({BoxFit fit, double width, double height}) {
    return CacheImageWidget(
      imageUrl: data.url,
      fit: fit,
      height: height,
      width: width,
      assetImageTag: PlaceHolderImages.bookImage,
    );
  }

  Hero hero({String extraTag = '', BoxFit fit, double width, double height}) {
    return Hero(
      tag: data.reference.path + '/' + extraTag,
      child: image(fit: fit, height: height, width: width),
    );
  }
}
