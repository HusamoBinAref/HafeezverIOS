import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/classes/thumbnail/src/model/media_info.dart';
import 'package:hafeez/generated/l10n.dart';

class VideoModel {
  static VideoModel build(MediaInfo mediaInfo) {
    if (mediaInfo == null) mediaInfo = MediaInfo();

    return VideoModel(
      title: mediaInfo.title,
      videoUrl: mediaInfo.url,
      thumbnailUrl: mediaInfo.thumbnailUrl,
    );
  }

  final String thumbnailUrl;
  final String videoUrl;
  final String title;

  VideoModel({this.thumbnailUrl, this.videoUrl, this.title});

  Future<String> add(DocumentReference itemReference) async {
    try {
      await itemReference
          .collection(KeyWords.itemKeyWords[2])
          .doc(S.current.languageCode)
          .set({"url": videoUrl});

      await itemReference.collection("Image").doc("image").set({"url": thumbnailUrl});

      return "done";
    } catch (e) {
      return "error" + " / " + e.toString();
    }
  }
}
