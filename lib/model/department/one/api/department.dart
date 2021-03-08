import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/department/one/model/data.dart';

class GetDepartment {
  final DocumentReference reference;

  GetDepartment({
    this.reference,
  });

  Stream<Department> get stream => reference.snapshots().map((_department) {
        if (_department.exists)
          return Department.toDepartment(_department);
        else
          return null;
      });

  Widget widget(Function(BuildContext context, Department department) builder, {Widget child}) {
    return StreamBuilder<Department>(
        stream: stream,
        builder: (context, _department) {
          if (Check.asyncSnapshot(_department)) {
            return builder(context, _department.data);
          } else
            return child == null ? Container() : child;
        });
  }
}
