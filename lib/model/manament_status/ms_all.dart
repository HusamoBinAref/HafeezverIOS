import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;

class ManagementState with ChangeNotifier {
  static const int increment = 6;
  int count = increment;

  ManagementState({
    List<DocumentReference> accountsReferences,
    DocumentReference departmentReference,
  }) {
    if (accountsReferences != null) {
      _accounts = accountsReferences;
    }

    if (departmentReference != null) {
      _departments.add(departmentReference);
    } else {
      _departments.add(FirebaseFirestore.instance.doc('Department/public'));
    }
  }

  List<DocumentReference> _departments = [];
  List<DocumentReference> get departments =>
      _departments.isNotEmpty ? List.from(_departments) : <DocumentReference>[];

  bool isDepartmentSelected(DocumentReference departmentReference) =>
      departments.contains(departmentReference);

  // words
  List<DocumentReference> _words = [];

  /// words
  List<DocumentReference> get words =>
      _words.isNotEmpty ? List.from(_words) : <DocumentReference>[];

  // accounts
  List<DocumentReference> _accounts = [];

  /// accounts
  List<DocumentReference> get accounts =>
      _accounts.isNotEmpty ? List.from(_accounts) : <DocumentReference>[];

  reload() {
    count = increment;
    this.notifyListeners();
  }

  more() {
    count += increment;
    this.notifyListeners();
  }

// departments
  addDepartment(DocumentReference departmentID, {bool marge = false}) {
    if (!marge) {
      _departments.clear();
    }

    _departments.add(departmentID);
    this.notifyListeners();
  }

  setDepartments(List<DocumentReference> departmentsReferences, {bool marge = false}) {
    if (!marge)
      _departments = departmentsReferences;
    else
      _departments.addAll(departmentsReferences);
    this.notifyListeners();
  }

// words
  addWord(DocumentReference wordID) {
    _words.add(wordID);
    this.notifyListeners();
  }

  setWords(List<DocumentReference> wordsId) {
    _words = wordsId;
    this.notifyListeners();
  }

  clearWords() {
    _words.clear();
    this.notifyListeners();
  }

  /// get all references
  ///
  List<DocumentReference> get references {
    List<DocumentReference> list = departments;
    list.removeWhere((element) => element.id.contains('public'));
    list.addAll(_accounts);
    list.addAll(_words);

    return list;
  }
}
