import 'package:flutter/material.dart';
import 'package:hafeez/model/department/set/api/get.dart';

class SpecializationsScreen extends StatelessWidget {
  const SpecializationsScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetDepartments.buildOrderByDate
          .widget((context, departments) => departments.widgets.list(context)),
    );
  }
}
