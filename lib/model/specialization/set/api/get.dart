import 'package:cloud_firestore/cloud_firestore.dart' show Query;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show BuildContext, StreamBuilder, Widget;
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/specialization/set/model/data.dart';

class GetSpecializations {
  static GetSpecializations get build {
    return GetSpecializations(
        reference: FirestoreSelectors.specialization);
  }

  static GetSpecializations get buildOrderByDate {
    return GetSpecializations(
      reference: FirestoreSelectors.specialization.orderBy(
        'createAt',
      ),
    );
  }

  final Query reference;

  GetSpecializations({
    @required this.reference,
  });
  static const double maxRowHeight = 30;

  /// * order by create date
  GetSpecializations byDate({bool isDescending = false}) => GetSpecializations(
        reference: isDescending
            ? reference.orderBy('createAt', descending: true)
            : reference.orderBy('createAt'),
      );

  Stream<Specializations> get stream {
    return reference.snapshots().map(Specializations.build);
  }

  Widget widget(
    Function(BuildContext context, Specializations specializations) builder, {
    Widget child,
  }) {
    return StreamBuilder<Specializations>(
      stream: stream,
      builder: (context, specializationsSnap) {
        if (Check.asyncSnapshot(specializationsSnap)) {
          return builder(context, specializationsSnap.data);
        } else
          return builder(context, Specializations(specializations: []));
      },
    );
  }
}
