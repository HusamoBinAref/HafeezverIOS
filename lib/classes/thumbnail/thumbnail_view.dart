import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';

import 'package:hafeez/widget/cache_image_widgets.dart';
import 'src/model/media_info.dart';

class MediaView extends StatelessWidget {
  /// Preview  media list thumbnail
  ///```dart
  /// List<MediaInfo> mediaList = [];
  /// List<String> urlList = ["https://www.youtube.com/watch?v=uv54ec8Pg1k"];
  /// Widget getMediaList(List<String> urlList) {
  ///   return MediaListView(
  ///     urls: urlList,
  ///     mediaList: mediaList,
  ///  );
  /// }
  ///```

  const MediaView({
    Key key,
    this.videoInfo,
    this.overlayChild,
    this.titleTextStyle,
    this.titleTextBackGroundColor,
    this.backgroundColor = Colors.transparent,
    this.bufferImageAsset = PlaceHolderImages.videoImage,
  }) : super(key: key);

  /// To show thumbnails list pass valid media url list.
  ///
  /// If this is set to null thumbnail list will create from media list
  ///
  /// If mediaList and urls both have values then thumbnail list will create using both list.
  ///
  ///  Example :-
  /// ```dart
  /// String url = "https://www.youtube.com/watch?v=uv54ec8Pg1k"
  /// ```
  final MediaInfo videoInfo;
  final String bufferImageAsset;

  /// The callback that returned url when the thiumbnail is tapped.

  /// if not provided, a PLAY icon will show
  final Widget overlayChild;

  /// the color of background
  final Color backgroundColor;

  /// this will set title text background Color
  ///
  /// If this is set to null, then default color value will set ` Colors.red`
  ///
  ///  Example :-
  /// ```dart
  /// titleTextBackGroundColor: Colors.grey[850]
  /// ```
  final Color titleTextBackGroundColor;

  /// this will set title text style
  ///
  /// If this is set to null, then default color value will set ` Colors.white`
  ///
  ///  Example :-
  /// ```dart
  /// titleTextStyle: TextStyle(color:Colors.white),
  /// ```
  final TextStyle titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: CacheImageWidget(
            imageUrl: videoInfo.thumbnailUrl ?? "",
            assetImageTag: bufferImageAsset,
            width: double.infinity,
          ),
        ),
        Container(
          child: overlayChild ??
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFBE0202),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
        ),
      ],
    );
  }
}
