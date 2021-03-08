import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/thumbnail/src/model/media_info.dart';
import 'package:hafeez/classes/thumbnail/src/resources/apiProvider.dart';
import 'package:hafeez/generated/l10n.dart';

import 'package:hafeez/model/Item/one/model/video/model/data.dart';

class GetItemVideo {
  final CollectionReference reference;
  final String defaultLanguage;

  /// object that will get youtube video info
  ThumbnailApiProvider _apiProvider = ThumbnailApiProvider();
  GetItemVideo({
    this.reference,
    this.defaultLanguage,
  });

  Stream<ItemVideo> get stream {
    return reference.doc(S.current.languageId).snapshots().map(ItemVideo.build);
  }

  Stream<ItemVideo> get defaultStream {
    return reference.doc(defaultLanguage).snapshots().map((_itemVideo) {
      return ItemVideo.build(_itemVideo, isPrimary: true);
    });
  }

  Widget widget(
    Function(BuildContext context, ItemVideo itemVideo) builder,
  ) {
    return StreamBuilder<ItemVideo>(
        stream: stream,
        builder: (context, _itemVideo) {
          if (Check.asyncSnapshot(_itemVideo)) {
            return builder(context, _itemVideo.data);
          } else
            return StreamBuilder<ItemVideo>(
                stream: defaultStream,
                builder: (context, _itemVideo2) {
                  if (Check.asyncSnapshot(_itemVideo2)) {
                    return builder(context, _itemVideo2.data);
                  } else
                    // return builder(
                    //     context, ItemVideo(reference: reference.doc(S.of(context).languageCode)));
                    return Container();
                });
        });
  }

  Widget videoBuilder({
    @required Function(BuildContext context, MediaInfo videoInfo, ItemVideo itemVideo) builder,
    Widget child,
  }) {
    return widget(
      (context, itemVideo) => FutureBuilder<MediaInfo>(
          future: _apiProvider.fetchMediaInfo(itemVideo.url),
          builder: (context, _videoInfoSnapshot) {
            if (Check.asyncSnapshot(_videoInfoSnapshot))
              return builder(context, _videoInfoSnapshot.data, itemVideo);
            else
              return child != null ? child : Container();
          }),
    );
  }

  Widget view() {
    return widget(
      (context, itemVideo) => Hero(
        tag: itemVideo.reference.parent.parent.path,
        child: Container(),
      ),
    );
  }
}
