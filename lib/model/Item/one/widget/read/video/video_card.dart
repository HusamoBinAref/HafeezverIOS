import 'package:flutter/material.dart';
import 'package:hafeez/classes/routing/api/screens.dart';

import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';

class VideoCard extends StatelessWidget {
  final ITem iTem;
  final ItemImage itemImage;
  final ItemVideo itemVideo;
  final ItemTitle itemTitle;
  final ItemDescription itemDescription;
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;

  const VideoCard({
    Key key,
    @required this.iTem,
    @required this.itemImage,
    @required this.itemVideo,
    @required this.itemTitle,
    this.itemDescription,
    this.account,
    this.imageProfile,
    this.nameProfile,
  }) : super(key: key);

  void onTap(
    BuildContext context,
  ) {
    ScreenRouting.toVideoScreen(context, iTem, itemTitle, itemDescription,
        itemImage, itemVideo, account, nameProfile, imageProfile);
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        child: GridTile(
          header: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: AccountTileReady(
              account: account,
              name: nameProfile,
              image: imageProfile,
              extraTag: iTem.reference.id,
            ),
          ),
          child: itemImage.widgets.hero(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          footer: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(5),
              child: itemTitle.widgets.hero(context, isEllipsis: true)),
        ),
        onTap: () => onTap(context),
      ),
    );
  }
}
