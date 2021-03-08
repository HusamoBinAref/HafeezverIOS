import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:hafeez/model/manament_status/getter_counter.dart';
import 'package:hafeez/model/manament_status/specializations_references.dart';


import 'accounts_references.dart';

class MSSheikh with ChangeNotifier {
  final int increment;
  AccountsReferences _accounts;
  SpecializationsReferences _specializations;
  GetterCounter counter;

  /// build
  MSSheikh({
    List<DocumentReference> accountsReferences,
    List<DocumentReference> specializationsReferences,
    this.increment = 10,
  }) {
    if (accountsReferences != null) {
      _accounts = AccountsReferences(
        accounts: accountsReferences,
        refresh: this.notifyListeners,
      );
    } else {
      _accounts = AccountsReferences(
        refresh: this.notifyListeners,
      );
    }

    if (specializationsReferences != null) {
      _specializations = SpecializationsReferences(
        specializations: specializationsReferences,
        refresh: this.notifyListeners,
      );
    } else {
      _specializations = SpecializationsReferences(
        refresh: this.notifyListeners,
      );
    }

    counter = GetterCounter(
      increment: increment,
      refresh: this.notifyListeners,
    );
  }

  // ignore: unused_field
  List<DocumentReference> _specializationsList = [];

  bool isSpecializationSelected(DocumentReference departmentReference) =>
      _specializations.getReferences.contains(departmentReference);

  addSpecialization(DocumentReference specializationID, {bool marge = false}) {
    if (!marge) {
      _specializations.clear();
    }

    _specializations.add(specializationID);
    this.notifyListeners();
  }

  /// get all references
  List<DocumentReference> get references {
    List<DocumentReference> list = _specializations.getReferences;
    list.removeWhere((element) => element.id.contains('public'));
    list.addAll(_accounts.getReferences);
    return list;
  }
}
