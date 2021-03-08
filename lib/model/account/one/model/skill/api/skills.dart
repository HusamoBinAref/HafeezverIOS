import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/skill/model/skill.dart';

class GetSkills {
  final CollectionReference reference;

  GetSkills({
    @required this.reference,
  });

  Stream<List<Skill>> get stream {
    return reference.snapshots().map((_skills) {
      if (_skills.docs.isNotEmpty) {
        return _skills.docs.map(Skill.toSkill).toList();
      } else
        return <Skill>[];
    });
  }

  Widget widget(Function(BuildContext context, List<Skill> skills) builder,
      {Widget child}) {
    return StreamBuilder<List<Skill>>(
        stream: stream,
        builder: (context, skillSnap) {
          if (Check.asyncSnapshot(skillSnap)) {
            return builder(context, skillSnap.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
