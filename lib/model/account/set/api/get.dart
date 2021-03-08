import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, Query;

import 'package:flutter/widgets.dart'
    show BuildContext, Container, StreamBuilder, Widget;
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/model/account/set/model/data.dart';

class GetAccounts {
  static GetAccounts build() {
    return GetAccounts(reference: FirestoreSelectors.user);
  }

  /// user reference
  final Query reference;

  GetAccounts({
    this.isByDate = false,
    this.isByReferences = false,
    this.isByType = false,
    this.reference,
  });

  final bool isByDate;
  final bool isByReferences;
  final bool isByType;

  /// * order by create date
  ///
  GetAccounts byDate({DateTime start, DateTime end, bool descending = false}) {
    if (!isByDate) {
      if (start != null && end != null) {
        return GetAccounts(
          isByDate: true,
          reference: reference
              .orderBy('createAt', descending: descending)
              .startAt([start]).endAt([end]),
        );
      } else if (start != null) {
        return GetAccounts(
          isByDate: true,
          reference: reference
              .orderBy('createAt', descending: descending)
              .startAt([start]),
        );
      } else if (end != null) {
        return GetAccounts(
          isByDate: true,
          reference: reference
              .orderBy('createAt', descending: descending)
              .endAt([end]),
        );
      } else {
        return GetAccounts(
            isByDate: true,
            reference: reference.orderBy('createAt', descending: descending));
      }
    } else
      return this;
  }

  GetAccounts get isSheikh => GetAccounts(
      reference: reference.where(KeyWords.isSheikh, isEqualTo: true));

  /// set the number of documents to get ...
  GetAccounts byLimits(int limits) =>
      GetAccounts(reference: reference.limit(limits));

  /// set the number of documents to get ...
  GetAccounts byReference(List<DocumentReference> references) =>
      references != null && references.isNotEmpty
          ? GetAccounts(
              reference: reference.where('userReference', whereIn: references))
          : this;

  GetAccounts byReferences(List<DocumentReference> references) =>
      references != null && references.isNotEmpty
          ? GetAccounts(
              reference:
                  reference.where('references', arrayContainsAny: references))
          : this;

  Stream<Accounts> get stream {
    return reference.snapshots().map(Accounts.build);
  }

  Widget widget(
    Widget Function(BuildContext context, Accounts accounts) builder,
  ) {
    return StreamBuilder<Accounts>(
        stream: stream,
        builder: (context, acconts) {
          if (Check.asyncQuerySnapshot(acconts)) {
            return builder(context, acconts.data);
          } else
            return Container();
        });
  }
}
