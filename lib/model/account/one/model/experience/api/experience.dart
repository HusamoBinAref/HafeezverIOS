import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import '../model/experience.dart';

class GetExperience {
  final CollectionReference reference;

  GetExperience({
    @required this.reference,
  });

  Stream<List<Experience>> get stream {
    return reference.snapshots().map((_experiences) {
      if (_experiences.docs.isNotEmpty) {
        return _experiences.docs.map(Experience.toExperience).toList();
      } else
        return <Experience>[];
    });
  }

  Widget widget(
      Function(BuildContext context, List<Experience> experiences) builder,
      {Widget child}) {
    return StreamBuilder<List<Experience>>(
        stream: stream,
        builder: (context, experienceSnap) {
          if (Check.asyncSnapshot(experienceSnap)) {
            return builder(context, experienceSnap.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
