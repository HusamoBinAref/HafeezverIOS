import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/set/api/get.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/accounts/report_accounts_row.dart';
import 'package:provider/provider.dart';

class ReportAccountsPage extends StatelessWidget {
  const ReportAccountsPage({
    Key key,
    this.getAccounts,
  }) : super(key: key);

  final GetAccounts getAccounts;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportInfo>(builder: (context, reportInfo, _) {
      return Column(
        children: [
          Card(
            child: ListTile(
              title: Text(S.of(context).accounts),
            ),
          ),
          Expanded(
            child: getAccounts
                .byDate(
              start: reportInfo.start,
              end: reportInfo.end,
            )
                .widget((context, accounts) {
              return ReportAccountsRow(
                accounts: accounts,
              );
            }),
          ),
        ],
      );
    });
  }
}
