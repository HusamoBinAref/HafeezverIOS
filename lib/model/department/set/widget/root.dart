import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show
        Axis,
        BorderRadius,
        BuildContext,
        Card,
        Colors,
        Container,
        EdgeInsets,
        Hero,
        LimitedBox,
        ListTile,
        ListView,
        Text,
        Theme,
        Widget;
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/department/set/api/get.dart';
import 'package:hafeez/model/department/set/model/data.dart';

class DepartmentsWidgets {
  final Departments data;

  DepartmentsWidgets({@required this.data});

  Widget list(BuildContext context) {
    data.departments.removeWhere(
        (department) => department.reference.id.contains('public'));
    return ListView.builder(
      itemCount: data.departments.length,
      primary: true,
      cacheExtent: 40,
      itemBuilder: (context, index) {
        var department = data.departments[index];
        return RoundedCard(
          margin: const EdgeInsets.all(5),
          borderRadius: BorderRadius.circular(15),
          child: ListTile(
            title: department.title.widget(
              builder: (context, departmentTitle) => ListTile(
                title: Hero(
                  tag: department.reference.path,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Text(
                      departmentTitle.text,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                onTap: () {
                  department.widgets
                      .goToScreen(context, title: departmentTitle);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget row(BuildContext context) {
    return LimitedBox(
      maxHeight: GetDepartments.maxRowHeight + 30,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20 / 2, horizontal: 10),
        child: ListView.separated(
          cacheExtent: 100,
          primary: true,
          scrollDirection: Axis.horizontal,
          itemCount: data.departments.length,
          itemBuilder: (context, i) {
            return data.departments[i].widgets.categoryTile();
          },
          separatorBuilder: (context, i) => Container(
              height: GetDepartments.maxRowHeight + 20,
              color: Theme.of(context).primaryColorLight,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 5)),
        ),
      ),
    );
  }
}
