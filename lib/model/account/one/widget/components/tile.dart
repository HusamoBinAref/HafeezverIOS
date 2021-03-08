import 'package:flutter/material.dart';

import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';

class AccountTileReady extends StatelessWidget {
  const AccountTileReady({
    Key key,
    @required this.account,
    @required this.name,
    @required this.image,
    this.extraTag = '',
    this.date,
    this.radius = 50,
    this.isHero = true,
  }) : super(key: key);
  final Account account;
  final NameProfile name;
  final ImageProfile image;
  final Widget date;
  final String extraTag;
  final double radius;
  final bool isHero;

  buildBody(BuildContext context) {
    return ListTile(
      onTap: () {
        account.widgets.goToScreenProfile(
          context,
          imageProfile: image,
          nameProfile: name,
          extraTag: extraTag,
        );
      },
      leading: image.widgets.circleImage(context,
          extraTag: extraTag, radius: radius, isHero: isHero),
      title: name.widgets.hero(context,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          extraTag: extraTag,
          isHero: isHero),
      subtitle: date,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isHero)
      return buildBody(context);
    else
      return Hero(
        tag: account.reference.path + "/" + extraTag,
        child: buildBody(context),
      );
  }
}
