import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';
import 'package:hafeez/widget/containers.dart';
import 'package:hafeez/model/Item/model/types/video/video_player_widget.dart';

class VideoTile extends StatefulWidget {
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final ITem iTem;
  final ItemTitle itemTitle;
  final ItemImage itemImage;
  final ItemVideo itemVideo;
  final bool isAccount;
  const VideoTile(
      {Key key,
      this.iTem,
      this.account,
      this.nameProfile,
      this.imageProfile,
      this.itemTitle,
      this.itemImage,
      this.itemVideo,
      this.isAccount = false})
      : super(key: key);

  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return widget.iTem.video.videoBuilder(
      builder: (context, videoInfo, itemVideo) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return HafeezVideoPlayer(
                    itemVideo: itemVideo,
                    account: widget.account,
                    nameProfile: widget.nameProfile,
                    imageProfile: widget.imageProfile,
                    iTem: widget.iTem,
                    itemImage: widget.itemImage,
                    itemTitle: widget.itemTitle);
              },
            ));
          },
          child: GridTile(
            child: CacheImageWidget(
              imageUrl: videoInfo.thumbnailUrl,
              assetImageTag: PlaceHolderImages.videoImage,
            ),
            footer: Text(
              videoInfo.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        );
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        height: double.infinity,
        width: double.infinity,
        child: Containers.waitting(context),
      ),
    );
  }
}
