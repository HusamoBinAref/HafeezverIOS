import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/report/model/data.dart';

class ReportDateUnitTypePopUp extends StatelessWidget {
  const ReportDateUnitTypePopUp({
    Key key,
    @required this.reportInfo,
  }) : super(key: key);
  final ReportInfo reportInfo;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(onSelected: (int index) {
      reportInfo.dateUnitIndex = index;
    }, itemBuilder: (context) {
      return <PopupMenuEntry<int>>[
        PopupMenuItem(value: 2, child: Text(S.of(context).by_day)),
        PopupMenuItem(value: 1, child: Text(S.of(context).by_month)),
      ];
    });
  }
}
