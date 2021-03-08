import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/specialization/one/model/specialization.dart';

class GetSpecialization {
  final DocumentReference reference;

  GetSpecialization({
    this.reference,
  });

  Stream<Specialization> get stream => reference.snapshots().map((_specialization) {
        if (_specialization.exists)
          return Specialization.toSpecialization(_specialization);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Specialization specialization) builder, {Widget child}) {
    return StreamBuilder<Specialization>(
        stream: stream,
        builder: (context, _specialization) {
          if (Check.asyncSnapshot(_specialization)) {
            return builder(context, _specialization.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
