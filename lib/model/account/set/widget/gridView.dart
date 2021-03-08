import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/public_variables.dart';
import 'package:hafeez/model/account/set/model/data.dart';
import 'package:hafeez/model/specialization/set/api/get.dart';
import 'package:hafeez/model/public/no_thing/widget/item.dart';

class AccountGridView extends StatelessWidget {
  const AccountGridView({Key key, @required this.data}) : super(key: key);
  final Accounts data;

  @override
  Widget build(BuildContext context) {
    if (data.accounts.isNotEmpty)
      return GridView.builder(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: GetSpecializations.maxRowHeight + 30,
          left: 10,
          right: 10,
        ),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: MediaCheckFunctions.accountCardAspectRatio,
            maxCrossAxisExtent: MediaCheckFunctions.maxWidthCard,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        primary: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        cacheExtent: MediaCheckFunctions.cacheItem,
        itemCount: data.accountsWithOutMe.length,
        itemBuilder: (context, index) {
          return data.accountsWithOutMe[index].widgets.card(
            context,
          );
        },
      );
    else
      return NoItemWidget();
  }
}
