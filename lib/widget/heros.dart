

import 'package:flutter/material.dart';

class Heros {
  static Hero homeIcon(BuildContext context, {Widget child}) {
    return Hero(tag: "homeHserIcon", child: child != null ? child : Container());
  }
}
