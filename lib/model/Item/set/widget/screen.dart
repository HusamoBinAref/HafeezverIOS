import 'package:flutter/material.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/model/manament_status/ms_all.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/Item/set/widget/CatagoryRow.dart';
import 'package:provider/provider.dart';

class ItemsScreen extends StatelessWidget {
  final GetItems items;
  final bool isDepartment;
  final bool isAccount;
  final String type;
  ItemsScreen({
    Key key,
    @required this.items,
    this.isDepartment = false,
    this.isAccount = false,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Consumer<ManagementState>(builder: (context, itemsManagement, _) {
          return Scaffold(
            body: items
                .byDate(descending: true)
                .byAnyReferences(itemsManagement.references)
                .byLimits(itemsManagement.count)
                .widget((context, items) {
              if (type == KeyWords.itemKeyWords[2])
                return items.widgets
                    .videoGridList(context, isDepartment: isDepartment);
              else if (type == KeyWords.itemKeyWords[3])
                return items.widgets
                    .audioGridList(context, isDepartment: isDepartment);
              else
                return items.widgets
                    .postGridList(context, isDepartment: isDepartment);
            }),
            floatingActionButton: FloatingActionButton(
                backgroundColor:
                    Theme.of(context).floatingActionButtonTheme.backgroundColor,
                tooltip: 'refresh',
                child: Icon(Icons.cloud_download),
                onPressed: () {
                  itemsManagement.more();
                }),
          );
        }),
        if (!isDepartment)
          Column(
            children: [
              Card(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                child: CatagoryRow(),
              ),
            ],
          ),
      ],
    );
  }
}
