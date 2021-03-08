import 'package:flutter/material.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/classes/tools/public_variables.dart';
import 'package:hafeez/model/account/set/model/data.dart';
import 'package:hafeez/model/specialization/set/api/get.dart';
import 'package:hafeez/model/public/no_thing/widget/item.dart';

class AccountListView extends StatelessWidget {
  const AccountListView({Key key, @required this.data}) : super(key: key);
  final Accounts data;

  @override
  Widget build(BuildContext context) {
    if (data.accounts.isNotEmpty)
      return ListView.separated(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: GetSpecializations.maxRowHeight + 30,
          left: 10,
          right: 10,
        ),
        primary: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        cacheExtent: MediaCheckFunctions.cacheItem,
        itemCount: data.accountsWithOutMe.length,
        itemBuilder: (context, index) {
          return RoundedCard(
            child: data.accountsWithOutMe[index].widgets.tileTile(context, extraTag: "tile"),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
    else
      return NoItemWidget();
  }
}
