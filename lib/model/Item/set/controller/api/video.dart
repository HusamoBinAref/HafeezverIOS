import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hafeez/classes/thumbnail/src/bloc/bloc.dart';
import 'package:hafeez/classes/thumbnail/src/model/media_info.dart';
import 'package:hafeez/classes/thumbnail/src/widget/add_thumbnail_widget.dart';
import 'package:hafeez/generated/l10n.dart';

import '../model/video.dart';
import '../widget/root.dart';

class VideoFunctions {
  static Future<void> addVideoLink(BuildContext context,
      {Function closing}) async {
    MediaInfo media = await showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(
                child: MultiBlocProvider(
              providers: [
                BlocProvider<ThumbnailBloc>(
                  create: (BuildContext context) => ThumbnailBloc(),
                ),
              ],
              child: AddMediaDialogContent(
                titleText: S.of(context).add_video_link,
                subTitleText: S.of(context).add_video_url,
                textFieldHintText: S.of(context).add_video_field_hint,
                errorText: S.of(context).add_video_error,
              ),
            ));
          },
        ));

    if (media != null) {
      ItemAddWidgets.video(
        context,
        model: VideoModel.build(media),
      );
    }
  }

  static Future<VideoModel> addVideoLink2(BuildContext context,
      {Function closing}) async {
    MediaInfo media = await showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(
                child: MultiBlocProvider(
              providers: [
                BlocProvider<ThumbnailBloc>(
                  create: (BuildContext context) => ThumbnailBloc(),
                ),
              ],
              child: AddMediaDialogContent(
                titleText: S.of(context).add_video_link,
                subTitleText: S.of(context).add_video_url,
                textFieldHintText: S.of(context).add_video_field_hint,
                errorText: S.of(context).add_video_error,
              ),
            ));
          },
        ));

    if (media != null) {
      return VideoModel.build(media);
    } else
      return null;
  }
}
