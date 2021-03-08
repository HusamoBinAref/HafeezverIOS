import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference, FirebaseFirestore;
import 'package:flutter/material.dart' show required;

class SpecializationsReferences {
  SpecializationsReferences({
    specializations,
    @required this.refresh,
  }) {
    if (specializations != null) _references = specializations;
  }

  final Function refresh;

  // specializations ..................................................................
  List<DocumentReference> _references = <DocumentReference>[
    FirebaseFirestore.instance.doc('Specialization/public')
  ];

  List<DocumentReference> get getReferences => List.from(_references);

  void add(DocumentReference reference) {
    _references.add(reference);
    refresh();
  }

  void addAll(List<DocumentReference> references) {
    _references.addAll(references);
    refresh();
  }

  void clear(){
    _references.clear();
    refresh();
  }
}
