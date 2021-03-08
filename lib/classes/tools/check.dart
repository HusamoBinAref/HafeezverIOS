import 'package:flutter/widgets.dart';

class Check {
  static bool asyncSnapshot(AsyncSnapshot snapshot) {
    return  snapshot.hasData;
  }

  static bool asyncQuerySnapshot(AsyncSnapshot querysnapshot) {
    return querysnapshot.hasData;
  }
}
