import 'dart:io' show File;

import 'package:flutter/material.dart' show TextEditingController;

class ImageController {
  File _file;
  TextEditingController _urlController = TextEditingController();
  String _type;

  File get file => (_file);
  set file(File fileValue) {
    if (fileValue != null) _file = fileValue;
  }

  TextEditingController get urlController => _urlController;

  String get type => _type ?? "none";
  set type(String value) {
    if (value != "") _type = value;
  }
}
