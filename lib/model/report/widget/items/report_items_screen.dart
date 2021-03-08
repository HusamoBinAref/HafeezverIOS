import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Container,
        Icon,
        IconButton,
        Icons,
        Key,
        Scaffold,
        StatelessWidget,
        Widget,
        required;
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/Item/one/model/data.dart';

import 'package:hafeez/model/Item/set/model/data.dart';

import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/time_picker.dart';

import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer;

import '../report_date_unit_type_pop_up.dart';

class ReportItemsScreen extends StatelessWidget {
  static navigator(
    BuildContext context, {
    @required ReportInfo reportInfo,
    @required Items items,
    @required String title,
  }) {
    ScreenRouting.navigator(
      context,
      child: ChangeNotifierProvider<ReportInfo>(
          create: (context) =>
              ReportInfo(startDate: reportInfo.start, endDate: reportInfo.end),
          builder: (context, snapshot) {
            return ReportItemsScreen(
              items: items,
              title: title,
            );
          }),
    );
  }

  const ReportItemsScreen({
    Key key,
    @required this.items,
    this.title = "",
  }) : super(key: key);

  final Items items;
  final String title;

  List<ITem> itemsList(DateTime start, DateTime end) {
    return items.list
        .where((item) =>
            !item.createAt.isBefore(start) && !item.createAt.isAfter(end))
        .toList();
  }

  List<DocumentReference> itemsDepartmentsReferences(ReportInfo reportInfo) {
    var listRf = itemsList(reportInfo.start, reportInfo.end).map((item) {
      return item.references.departmentsReferences;
    }).expand((element) => element);
    var setRf = listRf.toSet().toList();
    return setRf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ReportInfo>(builder: (context, reportInfo, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              ReportDateUnitTypePopUp(
                reportInfo: reportInfo,
              ),
              IconButton(
                  icon: Icon(Icons.calendar_today_rounded),
                  onPressed: () {
                    ScreenRouting.myShowDialog(context,
                        child: ReportDatePicker(report: reportInfo));
                  }),
            ],
          ),
          body: Container(),
          // body: MyDataGrid(
          //   itemsDataSource: ItemDataSource(items: items.list),
          // ),
        );
      }),
    );
  }
}
