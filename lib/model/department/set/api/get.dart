import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, Query;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show StreamBuilder, BuildContext, Widget;

import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/department/set/model/data.dart';

class GetDepartments {
  static GetDepartments get build {
    return GetDepartments(reference: FirestoreSelectors.departments);
  }

  static const double maxRowHeight = 35;

  static GetDepartments get buildOrderByDate {
    return build.byDate();
  }

  final Query reference;

  GetDepartments({
    @required this.reference,
  });

  /// * order by create date
  GetDepartments byDate({bool isDescending = false}) => GetDepartments(
        reference: isDescending
            ? reference.orderBy('createAt', descending: true)
            : reference.orderBy('createAt'),
      );

  Stream<Departments> get stream {
    return reference.snapshots().map(Departments.build);
  }

  Future<List<Department>> get future {
    return reference.get().then(
      (_departments) {
        if (_departments.docs.isNotEmpty) {
          return _departments.docs.map(Department.toDepartment).toList();
        } else
          return <Department>[];
      },
    );
  }

  Future<List<Department>> futureFun(List<DocumentReference> list) {
    return reference.get().then(
      (_departments) {
        if (_departments.docs.isNotEmpty) {
          return _departments.docs.map((department) {
            var departmentModel = Department.toDepartment(department);
            departmentModel.isSelected =
                list.contains(departmentModel.reference);

            return departmentModel;
          }).toList();
        } else
          return <Department>[];
      },
    );
  }

  Widget widget(
    Function(BuildContext context, Departments departments) builder, {
    Widget child,
  }) {
    return StreamBuilder<Departments>(
      stream: stream,
      builder: (context, departmentsSnap) {
        if (Check.asyncSnapshot(departmentsSnap)) {
          return builder(context, departmentsSnap.data);
        } else
          return builder(context, Departments(departments: []));
      },
    );
  }
}
