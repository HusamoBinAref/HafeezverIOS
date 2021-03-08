import 'package:flutter/material.dart';
import 'package:hafeez/model/public/cards/empty_card.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/widget/heros.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

class ImageProfileWidgets {
  final ImageProfile data;

  ImageProfileWidgets({@required this.data});
  Widget circleImage(BuildContext context, {String extraTag = "", double radius = 50, bool isHero = true}) {
    if (isHero)
      return Hero(
        tag: data.reference.path + '/' + extraTag,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).dividerColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: EmptyCard(
              child: CacheImageWidget(
                imageUrl: data.url,
                // width: double.infinity,
                // height: double.infinity,
                fit: BoxFit.cover,
                assetImageTag: PlaceHolderImages.userIcon,
              ),
            ),
          ),
        ),
      );
    else
      return CircleAvatar(
        backgroundColor: Theme.of(context).dividerColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: EmptyCard(
            child: CacheImageWidget(
              imageUrl: data.url,
              width: double.infinity,
              height: double.infinity,
              assetImageTag: PlaceHolderImages.userIcon,
            ),
          ),
        ),
      );
  }

  Widget homeCircleImage(
    BuildContext context,
  ) {
    return Heros.homeIcon(
      context,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).dividerColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: CacheImageWidget(
            imageUrl: data.url,
            width: double.infinity,
            height: double.infinity,
            assetImageTag: PlaceHolderImages.userIcon,
          ),
        ),
      ),
    );
  }

  Widget hero(
    BuildContext context, {
    String extraTag = "",
    fit = BoxFit.cover,
    double width,
    double height,
  }) {
    return Hero(
      tag: data.reference.path + '/' + extraTag,
      child: EmptyCard(
        child: CacheImageWidget(
          imageUrl: data.url,
          fit: fit,
          width: width,
          height: width,
          assetImageTag: PlaceHolderImages.userIcon,
        ),
      ),
    );
  }

  Widget heroOnDetails(
    BuildContext context, {
    String extraTag = "",
    fit = BoxFit.cover,
    double width,
    double height,
  }) {
    return Hero(
      tag: data.reference.path + '/' + extraTag,
      child: RoundedCard(
        margin: EdgeInsets.all(10),
        elevation: 2,
        borderRadius: BorderRadius.circular(1000),
        child: CacheImageWidget(
          imageUrl: data.url,
          fit: fit,
          width: width,
          height: width,
          assetImageTag: PlaceHolderImages.userIcon,
        ),
      ),
    );
  }
}
