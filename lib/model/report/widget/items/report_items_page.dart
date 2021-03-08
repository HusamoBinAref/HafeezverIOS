import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:hafeez/model/report/widget/items/report_items_row.dart';
import 'package:provider/provider.dart';

class ReportItemsPage extends StatelessWidget {
  const ReportItemsPage({
    Key key,
    @required this.getItems,
  }) : super(key: key);

  final GetItems getItems;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportInfo>(builder: (context, reportInfo, _) {
      return Column(
        children: [
          Card(
            child: ListTile(
              title: Text(S.of(context).elments),
            ),
          ),
          Expanded(
            child: getItems
                .byDate(
              start: reportInfo.start,
              end: reportInfo.end,
              descending: reportInfo.isDescending,
            )
                .widget((context, items) {
              return ReportItemsRow(items: items);
            }),
          ),
        ],
      );
    });
  }
}
