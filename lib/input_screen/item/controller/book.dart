import 'dart:io' show File;

import 'package:flutter/material.dart' show TextEditingController;

class BookController {
  File _file;
  TextEditingController _urlController = TextEditingController();
  String _type = "url";

  File get file => (_file);
  set file(File fileValue) {
    if (fileValue != null) _file = fileValue;
  }

  TextEditingController get urlController => _urlController;
  set url(String urlValue) {
    if (urlValue != "") _urlController.text = urlValue;
  }

  String get type => _type ?? "url";
  set type(String value) {
    if (value != "") _type = value;
  }
}
