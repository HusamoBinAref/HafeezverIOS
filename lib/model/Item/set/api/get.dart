import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/Item/set/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class GetItems {
  static GetItems build() {
    return GetItems(
      reference: FirestoreSelectors.rootItems,
    );
  }

  static GetItems buildForAccount(DocumentReference reference) {
    return GetItems(
      reference: reference.collection("Item"),
    );
  }

  /// * reference
  final Query reference;
  final DocumentReference currentRef;
  bool isByDate = false;
  bool isByReferences = false;
  bool isByType = false;

  GetItems({
    @required this.reference,
    this.currentRef,
  });

  /// * add current Item reference
  ///
  GetItems currentItem(DocumentReference documentReference) {
    if (documentReference != null) {
      return GetItems(reference: this.reference, currentRef: documentReference);
    } else {
      return this;
    }
  }

  /// * order by create date
  ///
  GetItems byDate({DateTime start, DateTime end, bool descending = false}) {
    if (!isByDate) {
      if (start != null && end != null) {
        return GetItems(
          reference: reference
              .orderBy('createAt', descending: descending)
              .startAt([start]).endAt([end]),
        );
      } else if (start != null) {
        return GetItems(
          reference: reference
              .orderBy('createAt', descending: descending)
              .startAt([start]),
        );
      } else if (end != null) {
        return GetItems(
          reference: reference
              .orderBy('createAt', descending: descending)
              .endAt([end]),
        );
      } else {
        return GetItems(
            reference: reference.orderBy('createAt', descending: descending));
      }
    } else
      return this;
  }

  /// * select types
  GetItems byTypes(String type) => type != null
      ? GetItems(reference: reference.where('type', isEqualTo: type))
      : this;

  /// * select types
  GetItems byAccount(DocumentReference accountReference) => accountReference !=
          null
      ? GetItems(
          reference:
              reference.where('accountReference', isEqualTo: accountReference))
      : this;

  /// * select references
  GetItems byAnyReferences(List<DocumentReference> references) {
    if (references != null && references.isNotEmpty && !isByReferences) {
      isByReferences = true;
      return GetItems(
          reference: reference.where(
        'references',
        arrayContainsAny: references,
      ));
    } else {
      return this;
    }
  }

  GetItems byReferences(List<DocumentReference> references) {
    if (references != null && references.isNotEmpty && !isByReferences) {
      isByReferences = true;
      return GetItems(
          reference: reference.where(
        'references',
        arrayContains: references,
      ));
    } else {
      return this;
    }
  }

  /// * set limit number
  GetItems byLimits(int limits) => limits != null && limits > 0
      ? GetItems(reference: reference.limit(limits))
      : this;

  /// * Stream
  Stream<Items> get stream => reference.snapshots().map(Items.build);

  /// * get widget has list of items if found
  Widget widget(
    Function(BuildContext context, Items items) builder,
  ) {
    return StreamBuilder<Items>(
        stream: stream,
        builder: (context, itemsSnap) {
          if (Check.asyncSnapshot(itemsSnap))
            return builder(context, itemsSnap.data);
          else if (itemsSnap.connectionState == ConnectionState.waiting)
            return Center(child: Containers.waitting(context));
          else
            return builder(context, Items.empty);
          // return Container();
        });
  }
}
