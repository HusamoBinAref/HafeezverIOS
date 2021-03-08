import 'package:flutter/material.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/Item/one/model/audio/model/data.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';

class AudioCard extends StatelessWidget {
  final ITem iTem;
  final ItemTitle itemTitle;
  final ItemDescription itemDescription;
  final ItemImage itemImage;
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final ItemAudio itemAudio;

  const AudioCard({
    Key key,
    @required this.iTem,
    @required this.imageProfile,
    @required this.itemTitle,
    @required this.itemImage,
    this.account,
    this.nameProfile,
    this.itemDescription,
    this.itemAudio,
  }) : super(key: key);

  void onTap(
    BuildContext context,
  ) {
    ScreenRouting.toAudioScreen(context, iTem, itemTitle, itemDescription,
        itemImage, itemAudio, account, nameProfile, imageProfile);
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).primaryColorLight,
      child: InkWell(
        child: GridTile(
          header: iTem.favoriteStatus.widget(builder: (context, favorite) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: favorite.widgets.icon(context),
                ),
              ],
            );
          }),
          child: itemImage.widgets.hero(
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover),
          footer: Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AccountTileReady(
                    account: account,
                    name: nameProfile,
                    image: imageProfile,
                    // date: iTem.widgets.createDateHero(context),
                    extraTag: iTem.reference.id,
                  ),
                  Divider(),
                  itemTitle.widgets.hero(context, isEllipsis: true),
                ],
              )),
        ),
        onTap: () => onTap(context),
      ),
    );
  }
}
