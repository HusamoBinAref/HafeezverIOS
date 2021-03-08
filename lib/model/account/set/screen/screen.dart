import 'package:flutter/material.dart';
import 'package:hafeez/model/manament_status/ms_sheikh.dart';
import 'package:hafeez/model/account/set/api/get.dart';
import 'package:hafeez/model/specialization/set/api/get.dart';
import 'package:provider/provider.dart' show Consumer;

class AccountsScreen extends StatefulWidget {
  final GetAccounts accounts;
  const AccountsScreen({
    Key key,
    @required this.accounts,
  }) : super(key: key);

  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  bool isCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Consumer<MSSheikh>(builder: (context, sheikhs, _) {
                  return Scaffold(
                    body: widget.accounts
                        .byReferences(sheikhs.references)
                        .byLimits(sheikhs.counter.value)
                        .byDate(descending: true)
                        .widget((context, accounts) {
                      if (isCard)
                        return accounts.widgets.grid(context);
                      else
                        return accounts.widgets.list(context);
                    }),
                    floatingActionButton: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                            backgroundColor: Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor,
                            tooltip: 'refresh',
                            heroTag: "download",
                            child: Icon(Icons.cloud_download),
                            onPressed: () {
                              sheikhs.counter.more();
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        FloatingActionButton(
                            backgroundColor: Theme.of(context)
                                .floatingActionButtonTheme
                                .backgroundColor,
                            tooltip: 'change view way',
                            heroTag: "view",
                            child: Icon(
                                isCard ? Icons.view_list : Icons.view_module),
                            onPressed: () {
                              setState(() {
                                isCard = !isCard;
                              });
                            }),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
          Column(
            children: [
              Card(
                color: Theme.of(context).primaryColor.withOpacity(0.7),
                child: GetSpecializations.build
                    .byDate(isDescending: true)
                    .widget((context, specializations) =>
                        specializations.widgets.row(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
