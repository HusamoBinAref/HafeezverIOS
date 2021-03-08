import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/skill/model/skill.dart';

class GetSkill {
  final DocumentReference reference;
  GetSkill({
    this.reference,
  });

  Stream<Skill> get stream => reference.snapshots().map((_skill) {
        if (_skill.exists)
          return Skill.toSkill(_skill);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Skill skill) builder,
      {Widget child}) {
    return StreamBuilder<Skill>(
        stream: stream,
        builder: (context, _skill) {
          if (Check.asyncSnapshot(_skill)) {
            return builder(context, _skill.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
