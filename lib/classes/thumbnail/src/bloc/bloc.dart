import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hafeez/classes/thumbnail/src/bloc/thumbnail_event.dart';
import 'package:hafeez/classes/thumbnail/src/bloc/thumbnail_state.dart';
import 'package:hafeez/classes/thumbnail/src/resources/repository.dart';

class ThumbnailBloc extends Bloc<ThumbnailEvent, ThumbnailState> {
  final Repository repo = Repository();

  ThumbnailBloc() : super(null);

  ThumbnailState get initialState => DialogOpened();

  @override
  Stream<ThumbnailState> mapEventToState(ThumbnailEvent event) async* {
    if (event is AddUrl) {
      try {
        yield LoadingMedia();
        var media = await repo.fetchAllNews(link: event.url);

        yield LoadedMedia(mediaInfo: media);
      } catch (_) {
        yield FailureDetail();
      }
    }
    if (event is UrlChange) {
      yield UrlChanged();
    }
  }
}
