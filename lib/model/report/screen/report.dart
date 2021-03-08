import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        DefaultTabController,
        Icon,
        IconButton,
        Icons,
        Key,
        Scaffold,
        StatelessWidget,
        TabBar,
        TabBarView,
        Widget;
import 'package:hafeez/Details/detials_static.dart';

import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/account/set/api/get.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/accounts/report_accounts_page.dart';
import 'package:hafeez/model/report/widget/report_date_unit_type_pop_up.dart';
import 'package:hafeez/model/report/widget/report_departments_page.dart';
import 'package:hafeez/model/report/widget/items/report_items_page.dart';
import 'package:hafeez/model/report/widget/time_picker.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  static navigator(BuildContext context) {
    ScreenRouting.navigator(
      context,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ReportInfo()),
        ],
        child: ReportScreen(),
      ),
    );
  }

  const ReportScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Consumer<ReportInfo>(builder: (context, reportInfo, _) {
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
              bottom: TabBar(
                // page tabs
                tabs: [
                  Icon(
                    DetailsCollections.shiekhs(context).iconData,
                    size: 30,
                  ),
                  Icon(
                    DetailsCollections.posts(context).iconData,
                    size: 30,
                  ),
                  Icon(
                    DetailsCollections.departments(context).iconData,
                    size: 30,
                  ),
                ],
              ),
            ),
            body: TabBarView(children: [
              ReportAccountsPage(
                getAccounts: GetAccounts.build(),
              ),
              ReportItemsPage(
                getItems: GetItems.build(),
              ),
              ReportDepartmentsPage(),
            ]),
          );
        }),
      ),
    );
  }
}
