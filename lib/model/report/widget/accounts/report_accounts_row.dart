import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/set/model/data.dart';
import 'package:hafeez/model/report/api/get_date_time_units.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/report_card.dart';
import 'package:hafeez/model/report/widget/report_chart.dart';
import 'package:provider/provider.dart';

class ReportAccountsRow extends StatelessWidget {
  const ReportAccountsRow({
    Key key,
    @required this.accounts,
    this.cardWidth = 150,
  }) : super(key: key);
  final Accounts accounts;
  final double cardWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<ReportInfo>(builder: (context, reportInfo, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (reportInfo.dateUnitIndex == 0)
              buildChartByDays(reportInfo)
            else if (reportInfo.dateUnitIndex == 1)
              buildChartByMonths(reportInfo)
            else if (reportInfo.dateUnitIndex == 2)
              buildChartByDays(reportInfo),
            buildRowAccounts(reportInfo, context),
          ],
        );
      }),
    );
  }

  Widget buildRowAccounts(ReportInfo reportInfo, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CardReport(
            width: cardWidth,
            color: reportInfo.allAccounts.color,
            title: reportInfo.allAccounts.title,
            value: accounts.accounts.length.toString(),
            onTap: () {
              // ReportAccountsScreen.navigator(context,
              //     accounts: accounts, title: reportInfo.allAccounts.title);
            },
          ),
          CardReport(
            width: cardWidth,
            color: reportInfo.sheikhes.color,
            title: reportInfo.sheikhes.title,
            value:
                accounts.getByType(isSheikh: true).accounts.length.toString(),
            onTap: () {
              // ReportAccountsScreen.navigator(context,
              //     accounts: accounts.getByType(isSheikh: true),
              //     title: reportInfo.sheikhes.title);
            },
          ),
          CardReport(
            width: cardWidth,
            color: reportInfo.visiters.color,
            title: reportInfo.visiters.title,
            value:
                accounts.getByType(isSheikh: false).accounts.length.toString(),
            onTap: () {
              // ReportAccountsScreen.navigator(context,
              //     accounts: accounts.getByType(isSheikh: false),
              //     title: reportInfo.visiters.title);
            },
          ),
        ],
      ),
    );
  }

  Card buildChartByMonths(ReportInfo reportInfo) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ReportChart(
          title: S.current.monthly_report_of + S.current.accounts,
          lines: [
            DateTimeUnits.getAccountsLineByMonths(
              accountsList: accounts.accounts,
              color: reportInfo.allAccounts.color,
              type: reportInfo.allAccounts.title +
                  " ( " +
                  accounts.accounts.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getAccountsLineByMonths(
              accountsList: accounts.getByType(isSheikh: true).accounts,
              color: reportInfo.sheikhes.color,
              type: reportInfo.sheikhes.title +
                  " ( " +
                  accounts
                      .getByType(isSheikh: true)
                      .accounts
                      .length
                      .toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getAccountsLineByMonths(
              accountsList: accounts.getByType(isSheikh: false).accounts,
              color: reportInfo.visiters.color,
              type: reportInfo.visiters.title +
                  " ( " +
                  accounts
                      .getByType(isSheikh: false)
                      .accounts
                      .length
                      .toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
          ],
        ),
      ),
    );
  }

  Card buildChartByDays(ReportInfo reportInfo) {
    return Card(
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: ReportChart(
          title: S.current.dayly_report_of + S.current.accounts,
          lines: [
            DateTimeUnits.getAccountsLineByDays(
              accountsList: accounts.accounts,
              color: reportInfo.allAccounts.color,
              type: reportInfo.allAccounts.title +
                  " ( " +
                  accounts.accounts.length.toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getAccountsLineByDays(
              accountsList: accounts.getByType(isSheikh: true).accounts,
              color: reportInfo.sheikhes.color,
              type: reportInfo.sheikhes.title +
                  " ( " +
                  accounts
                      .getByType(isSheikh: true)
                      .accounts
                      .length
                      .toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
            DateTimeUnits.getAccountsLineByDays(
              accountsList: accounts.getByType(isSheikh: false).accounts,
              color: reportInfo.visiters.color,
              type: reportInfo.visiters.title +
                  " ( " +
                  accounts
                      .getByType(isSheikh: false)
                      .accounts
                      .length
                      .toString() +
                  " ) ",
              start: reportInfo.start,
              end: reportInfo.end,
            ),
          ],
        ),
      ),
    );
  }
}
