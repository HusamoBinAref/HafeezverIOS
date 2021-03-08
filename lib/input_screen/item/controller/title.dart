import 'package:flutter/material.dart' show TextEditingController;
import '../../../model/language/one/model/data.dart';

class TitleController {
  TextEditingController controller = TextEditingController();
  bool isWork = false;
  final Language language;

  TitleController({this.language, this.controller});
}
