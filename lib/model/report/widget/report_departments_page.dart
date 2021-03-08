import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/department/set/api/get.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:provider/provider.dart';

class ReportDepartmentsPage extends StatelessWidget {
  const ReportDepartmentsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportInfo>(builder: (context, reportInfo, _) {
      return Column(
        children: [
          Card(
            child: ListTile(
              title: Text(S.of(context).departments),
            ),
          ),
          Expanded(
            child: GetDepartments.build.widget((context, departments) {
              departments.departments.removeWhere(
                  (department) => department.reference.id == "public");
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: departments.departments.map((department) {
                        return RoundedCard(
                          margin: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 0),
                          child: Container(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  department.title.widget(
                                      builder: (context, title) =>
                                          Text(title.text)),
                                  ReportDepartmentItemsCard(
                                    department: department,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}

class ReportDepartmentItemsCard extends StatelessWidget {
  const ReportDepartmentItemsCard({
    Key key,
    @required this.department,
  }) : super(key: key);
  final Department department;
  @override
  Widget build(BuildContext context) {
    return Consumer<ReportInfo>(builder: (context, reportInfo, _) {
      return GetItems.build()
          .byDate(
        start: reportInfo.start,
        end: reportInfo.end,
      )
          .byAnyReferences([department.reference]).widget(
        (context, items) => Text(items.list.length.toString()),
      );
    });
  }
}
