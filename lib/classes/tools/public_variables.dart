import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../commends/storage.dart';

class PublicVariables {
  static const axisCount = 12;
}

class MediaCheckFunctions {
  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static bool isOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static double height(BuildContext context) => size(context).height;
  static double width(BuildContext context) => size(context).width;

  static int crossAxisCount(BuildContext context) {
    var count = MediaCheckFunctions.width(context) ~/ maxWidthCard;
    return count > 0 ? count : 1;
  }

  static const double maxWidthCard = 200;
  static const double maxWidthPostCard = 400;
  static const double maxWidthBookCard = 400;
  static const double maxWidthVideoCard = 800;
  static const double maxWidthVoiceCard = 400;

  static const double itemCardAspectRatio = 20 / 25;
  static const double videoCardAspectRatio = 16 / 12;
  static const double bookCardAspectRatio = 20 / 32;
  static const double postCardAspectRatio = 20 / 32;
  static const double voiceCardAspectRatio = 20 / 32;
  static const double reitemCardAspectRatio = 35 / 20;
  static const double accountCardAspectRatio = 20 / 27;
  static const double cacheItem = 50;
}

class MediaUpLoadFunctions {
  static Future<String> upLoading(
    BuildContext context, {
    @required String path,
    @required File file,
    Function(double value) refreshProgress,
  }) async {
    try {
      final StorageReference storageReference =
          StorageManagerCommends.storage.ref().child(path);

      final StorageUploadTask uploadTask = storageReference.putFile(file);

      final StreamSubscription<StorageTaskEvent> streamSubscription =
          uploadTask.events.listen((event) {
        var totalBytes = event.snapshot.totalByteCount;
        var transferred = event.snapshot.bytesTransferred;

        refreshProgress(((transferred * 100) / totalBytes) / 100);
      });

      StorageTaskSnapshot onComplete = await uploadTask.onComplete;

      String fileUrl = await onComplete.ref.getDownloadURL();

      if (fileUrl != null && fileUrl != '') {
        streamSubscription.cancel();

        return fileUrl;
      } else
        return "error";
    } catch (e) {
      return throw e.toString();
    }
  }
}
