import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/department/set/widget/root.dart';

class Departments {
  static Departments build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty)
      return Departments(departments: snapshot.docs.map(Department.toDepartment).toList());
    else
      return Departments(departments: []);
  }

  final List<Department> departments;

  Departments({@required this.departments});
  DepartmentsWidgets get widgets => DepartmentsWidgets(data: this);
  List<Department> get selected => departments.where((element) => element.isSelected).toList();
}
