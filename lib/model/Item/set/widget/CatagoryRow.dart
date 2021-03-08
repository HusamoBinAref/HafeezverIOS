import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/model/department/set/api/get.dart';

class CatagoryRow extends StatelessWidget {
  CatagoryRow({
    Key key,
    this.kDefaultPadding = 20,
  }) : super(key: key);

  final double kDefaultPadding;

  @override
  Widget build(BuildContext context) {
    return GetDepartments.build.byDate().widget((context, departments) => departments.widgets.row(context));
  }
}
