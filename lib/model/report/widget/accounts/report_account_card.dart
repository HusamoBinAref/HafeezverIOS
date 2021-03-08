import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        Container,
        EdgeInsets,
        Icon,
        Icons,
        Key,
        ListTile,
        PopupMenuButton,
        PopupMenuEntry,
        PopupMenuItem,
        Row,
        StatelessWidget,
        Text,
        TextStyle,
        Theme,
        Widget,
        required;

import 'package:hafeez/generated/l10n.dart';

import 'package:hafeez/model/Item/set/api/get.dart';

import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/report/model/data.dart';
import 'package:provider/provider.dart';

import 'one/report_account_screen.dart';

class ReportAccountCard extends StatelessWidget {
  const ReportAccountCard({
    Key key,
    @required this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Consumer<ReportInfo>(builder: (context, reportInfo, _) {
      return Container(
        child: account.profile.image.widget(
          (context, image) => account.profile.names.currentName(
            (context, name) => account.profile.email.widget(
              (context, email) => RoundedCard(
                elevation: 1,
                margin:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
                child: Center(
                  child: ListTile(
                    leading: image.widgets.circleImage(context),
                    title: name.widgets.hero(context),
                    subtitle: Row(
                      children: [
                        Text(
                          account.createString,
                        ),
                        if (account.isSheikh)
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              width: 2,
                              height: 15,
                              color: Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(0.3)),
                        if (account.isSheikh)
                          GetItems.buildForAccount(account.snapshot.reference)
                              .byDate(
                                  start: reportInfo.start, end: reportInfo.end)
                              .widget((context, items) => Text(
                                    S.of(context).elments +
                                        " : " +
                                        items.list.length.toString(),
                                  )),
                      ],
                    ),
                    trailing: PopupMenuButton<int>(
                      color: Theme.of(context).primaryColorLight,
                      icon: Icon(
                        Icons.list,
                        color: Theme.of(context).primaryColorLight,
                      ),
                      onSelected: (int result) {
                        if (result == 0) {
                          account.widgets.goToScreenProfile(context,
                              nameProfile: name, imageProfile: image);
                        } else if (result == 1) {
                          ReportAccontScreen.navigator(context, account,
                              nameProfile: name,
                              imageProfile: image,
                              reportInfo: reportInfo);
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(
                          value: 0,
                          child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                "profile",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )),
                        ),
                        if (account.isSheikh)
                          PopupMenuItem<int>(
                            value: 1,
                            child: ListTile(
                                leading: Icon(
                                  Icons.receipt_long_outlined,
                                  color: Theme.of(context).primaryColor,
                                ),
                                title: Text(
                                  "dateils",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
