import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/material.dart' show required;

class AccountsReferences {
  AccountsReferences({
    accounts,
    @required this.refresh,
  }) {
    if (accounts != null) _references = accounts;
  }

  final Function refresh;

// accounts ..................................................................
  List<DocumentReference> _references = <DocumentReference>[];

  List<DocumentReference> get getReferences => List.from(_references);

  void add(DocumentReference reference) {
    _references.add(reference);
    refresh();
  }

  void addAll(List<DocumentReference> references) {
    _references.addAll(references);
    refresh();
  }
}
