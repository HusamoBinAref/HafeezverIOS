import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/Item/model/types/video/video_player_widget.dart';

class Video extends StatelessWidget {
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final ITem iTem;
  final ItemTitle itemTitle;
  final ItemImage itemImage;
  final ItemVideo itemVideo;
  final ItemDescription itemDescription;
  final bool isAccount;
  const Video({
    Key key,
    @required this.account,
    @required this.nameProfile,
    @required this.imageProfile,
    @required this.iTem,
    @required this.itemTitle,
    @required this.itemImage,
    @required this.itemVideo,
    @required this.itemDescription,
    this.isAccount = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      clipBehavior: Clip.antiAlias,
      child: GridTile(
        header: AccountTileReady(
          account: account,
          image: imageProfile,
          name: nameProfile,
          extraTag: iTem.reference.id,
          date: iTem.widgets.createDateHero(context),
        ),
        child: Container(
          height: double.infinity,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return HafeezVideoPlayer(
                      itemVideo: itemVideo,
                      account: account,
                      nameProfile: nameProfile,
                      imageProfile: imageProfile,
                      iTem: iTem,
                      itemImage: itemImage,
                      itemTitle: itemTitle);
                },
              ));
            },
            child: itemImage.widgets.hero(),
          ),
        ),
        footer: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: itemTitle.widgets.hero(context),
          ),
        ),
      ),
    );
  }
}
