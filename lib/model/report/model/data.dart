import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, IconData;
import 'package:hafeez/generated/l10n.dart';
import 'package:intl/intl.dart';

class ReportInfo with ChangeNotifier {
// date unit
  int _dateUnitIndex = 1;
  int get dateUnitIndex => _dateUnitIndex;
  set dateUnitIndex(int index) {
    _dateUnitIndex = index;
    notifyListeners();
  }

// feilds informations
  final FeildInfo allItems = FeildInfo(title: S.current.all, color: Colors.red),
      books = FeildInfo(title: S.current.books, color: Colors.blue),
      posts = FeildInfo(title: S.current.posts, color: Colors.green),
      videos = FeildInfo(title: S.current.videos, color: Colors.orange),
      voices = FeildInfo(title: S.current.voices, color: Colors.deepPurple),
      allAccounts = FeildInfo(title: S.current.account, color: Colors.red),
      sheikhes = FeildInfo(title: S.current.sheikhs, color: Colors.orange),
      visiters = FeildInfo(title: S.current.visiters, color: Colors.blue);

  ReportInfo({DateTime startDate, DateTime endDate}) {
    if (startDate != null) _start = startDate;
    if (endDate != null) _end = endDate;
  }
  DateTime _start = DateTime.now().subtract(Duration(days: 70));
  DateTime get start => _start;
  set start(DateTime date) {
    _start = date;
    notifyListeners();
  }

  String get formatedStartTime {
    return DateFormat.yMMMd(S.current.languageCode).format(start);
  }

  DateTime _end = DateTime.now();
  DateTime get end => _end;
  set end(DateTime date) {
    _end = date ?? DateTime.now();
    notifyListeners();
  }

  String get formatedEndTime {
    return DateFormat.yMMMd(S.current.languageCode).format(end);
  }

  bool isDescending = false;

  List<DocumentReference> _accountsReferences = <DocumentReference>[];
  set addAccountReferences(DocumentReference reference) {
    _accountsReferences.add(reference);
    notifyListeners();
  }

  set removeAccountReferences(DocumentReference reference) {
    _accountsReferences.remove(reference);
    notifyListeners();
  }

  List<DocumentReference> _departmentsReferences = <DocumentReference>[];
  set addDepartmentReferences(DocumentReference reference) {
    _departmentsReferences.add(reference);
    notifyListeners();
  }

  set removeDepartmentReferences(DocumentReference reference) {
    _departmentsReferences.remove(reference);
    notifyListeners();
  }

  List<DocumentReference> _wordsReferences = <DocumentReference>[];
  set addWordReferences(DocumentReference reference) {
    _wordsReferences.add(reference);
    notifyListeners();
  }

  set removeWordReferences(DocumentReference reference) {
    _wordsReferences.remove(reference);
    notifyListeners();
  }

  List<DocumentReference> _languagesReferences = <DocumentReference>[];
  set addLanguageReferences(DocumentReference reference) {
    _languagesReferences.add(reference);
    notifyListeners();
  }

  set removeLanguageReferences(DocumentReference reference) {
    _languagesReferences.remove(reference);
    notifyListeners();
  }

  List<DocumentReference> _specializationsReferences = <DocumentReference>[];
  set addSpecializationReferences(DocumentReference reference) {
    _specializationsReferences.add(reference);
    notifyListeners();
  }

  set removeSpecializationReferences(DocumentReference reference) {
    _specializationsReferences.remove(reference);
    notifyListeners();
  }

  List<DocumentReference> get allReferences => <DocumentReference>[
        ..._accountsReferences,
        ..._departmentsReferences,
        ..._wordsReferences,
        ..._languagesReferences,
        ..._specializationsReferences,
      ];
}

class FeildInfo {
  final String title;
  final Color color;
  final IconData iconData;

  FeildInfo({this.title, this.color, this.iconData});
}
