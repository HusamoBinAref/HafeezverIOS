import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HafeezVideoPlayer extends StatefulWidget {
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final ITem iTem;
  final ItemImage itemImage;
  final ItemTitle itemTitle;
  final ItemVideo itemVideo;
  final bool autoPlay;
  final bool isLive;
  final bool controlsVisibleAtStart;
  final bool showVideoProgressIndicator;
  final String captionLanguage;

  const HafeezVideoPlayer({
    Key key,
    @required this.itemVideo,
    @required this.account,
    @required this.nameProfile,
    @required this.imageProfile,
    @required this.iTem,
    @required this.itemImage,
    @required this.itemTitle,
    this.autoPlay = false,
    this.isLive = false,
    this.controlsVisibleAtStart = false,
    this.showVideoProgressIndicator = true,
    this.captionLanguage,
  }) : super(key: key);
  @override
  _HafeezVideoPlayerState createState() => _HafeezVideoPlayerState();
}

class _HafeezVideoPlayerState extends State<HafeezVideoPlayer> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.itemVideo.url),
        flags: YoutubePlayerFlags(
          isLive: widget.isLive,
          autoPlay: widget.autoPlay,
          controlsVisibleAtStart: widget.controlsVisibleAtStart,
          captionLanguage: S.of(context).languageCode,
        ));

    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: widget.showVideoProgressIndicator,
              width: double.infinity,
              thumbnail: CacheImageWidget(
                imageUrl: widget.itemImage.url,
                assetImageTag: PlaceHolderImages.videoImage,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.itemTitle.text,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ),
            Divider(),
            AccountTileReady(
              account: widget.account,
              image: widget.imageProfile,
              name: widget.nameProfile,
              extraTag: widget.iTem.reference.id,
              date: widget.iTem.widgets.createDateHero(context),
            ),
          ],
        ),
      ),
    );
  }

  
}
