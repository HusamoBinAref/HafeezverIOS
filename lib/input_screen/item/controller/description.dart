import 'package:flutter/material.dart'show TextEditingController;
import '../../../model/language/one/model/data.dart';

class DescriptionController {
  final TextEditingController controller = TextEditingController();
  bool isWork = false;
  final Language language;

  DescriptionController({this.language});
}
