import 'package:flutter/material.dart';

import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/classes/tools/public_variables.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/image/one/widget/edit/image.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../model/data.dart';

class VideoDetailsScreen extends StatefulWidget {
  VideoDetailsScreen({
    Key key,
    @required this.iTem,
    @required this.itemImage,
    @required this.itemVideo,
    @required this.itemTitle,
    @required this.itemDescription,
    this.nameProfile,
    this.imageProfile,
    this.account,
    this.extraTag = '',
  }) : super(key: key);

  final ITem iTem;
  final ItemImage itemImage;
  final ItemVideo itemVideo;
  final ItemTitle itemTitle;
  final ItemDescription itemDescription;
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;
  final String extraTag;

  @override
  _VideoDetailsScreenState createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  YoutubePlayerController _controller;
  int page = 0;
  @override
  void initState() {
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.itemVideo.url),
        flags: YoutubePlayerFlags(
          autoPlay: true,
          controlsVisibleAtStart: true,
        ));
    super.initState();
  }

  @override
  void dispose() {
    if (_controller.value.isFullScreen) _controller.toggleFullScreenMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            children(context),
            if (!MediaCheckFunctions.isOrientation(context) && false)
              Card(
                color: Theme.of(context).primaryColorLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: S.of(context).description,
                      icon: Icon(
                        Icons.receipt_long,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (page != 0)
                          setState(() {
                            page = 0;
                          });
                      },
                    ),
                    IconButton(
                      tooltip: S.of(context).departments +
                          " , " +
                          S.of(context).words,
                      icon: Icon(
                        Icons.group_work,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (page != 1)
                          setState(() {
                            page = 1;
                          });
                      },
                    ),
                    IconButton(
                      tooltip: S.of(context).items_like,
                      icon: Icon(
                        Icons.link,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (page != 2)
                          setState(() {
                            page = 2;
                          });
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Column(
        children: actions(context),
      ),
    );
  }

  Widget children(
    BuildContext context,
  ) {
    if (page == 0) {
      var videoWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VideoStack(controller: _controller, widget: widget),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedCard(
              elevation: 0,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  Expanded(
                    child: AccountTileReady(
                      account: widget.account,
                      name: widget.nameProfile,
                      image: widget.imageProfile,
                      date: widget.iTem.widgets.createDateHero(context),
                      extraTag: widget.iTem.reference.id,
                    ),
                  ),
                  widget.iTem.widgets.buttons(context),
                ],
              ),
            ),
          ),
          title.widgets.hero2(context),
          if (description.text.trim() != "") description.widgets.hero2(context),
        ],
      );
      return childrenInfo(context, child: videoWidget);
    } else
      return Container();
  }

  Widget childrenInfo(BuildContext context, {@required Widget child}) {
    return MediaCheckFunctions.isOrientation(context)
        ? child
        : SafeArea(child: child);
  }

  ItemTitle get title => widget.itemTitle;
  ItemDescription get description => widget.itemDescription;

  List<Widget> actions(BuildContext context) => [
        Spacer(),
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          GetAuthentication().showIfEdittingIsAllow(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  heroTag: "edit info",
                  child: Icon(
                    Icons.mode_edit,
                  ),
                  onPressed: () {
                    widget.iTem.widgets.showEdittingScreen(context, () {});
                  }),
            ),
            reference: widget.iTem.user.reference,
          ),
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          GetAuthentication().showIfEdittingIsAllow(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  heroTag: "edit image",
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ModifyImageWidget(
                        itemImage: widget.itemImage,
                      );
                      // return Scaffold(body: Container());
                    }));
                  }),
            ),
            reference: widget.iTem.user.reference,
          ),
      ];
}

class VideoStack extends StatelessWidget {
  const VideoStack({
    Key key,
    @required YoutubePlayerController controller,
    @required this.widget,
  })  : _controller = controller,
        super(key: key);

  final YoutubePlayerController _controller;
  final VideoDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          width: double.infinity,
          thumbnail: widget.itemImage.widgets.hero(
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RoundedCard(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
