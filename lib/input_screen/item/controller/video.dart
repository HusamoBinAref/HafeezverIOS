
import 'dart:io'show File;

import 'package:flutter/material.dart' show TextEditingController;

class VideoController {
  File _file;
  TextEditingController _urlController = TextEditingController();
  String _type;

  File get file => (_file);
  set file(File fileValue) {
    if (fileValue != null) _file = fileValue;
  }

  TextEditingController get urlController => _urlController ;
  set url(String urlValue) {
    if (urlValue != "") _urlController.text = urlValue;
  }

  String get type => _type ?? "none";
  set type(String value) {
    if (value != "") _type = value;
  }
}
