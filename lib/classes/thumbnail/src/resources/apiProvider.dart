import 'dart:convert';

import 'package:hafeez/classes/thumbnail/src/model/media_info.dart';
import 'package:http/http.dart' as http;


class ThumbnailApiProvider {

  Future<MediaInfo> fetchMediaInfo (String videoUrl) async {
    if(videoUrl == null || videoUrl.isEmpty){
      return null;
    }
    return await http.Client()
        .get("https://noembed.com/embed?url=" + videoUrl)
        .then((result) => result.body)
        .then(json.decode)
        .then((json) =>MediaInfo.fromJson(json));
  }
}