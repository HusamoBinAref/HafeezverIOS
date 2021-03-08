import 'package:flutter/material.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/department/one/model/title/one/model/title.dart';

class DepartmentTitleWidgets {
  final DepartmentTitle data;

  DepartmentTitleWidgets({@required this.data});

  Widget selectionTile(BuildContext context, {Function refresh, Department department}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
            selectedTileColor: Theme.of(context).primaryColorLight,
            title: Text(
              data.text,
              style: department.isSelected
                  ? Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Theme.of(context).primaryColor)
                  : Theme.of(context).textTheme.subtitle1,
            ),
            selected: department.isSelected,
            onTap: () {
              department.isSelected = !department.isSelected;
              refresh();
            }),
      ),
    );
  }
}
