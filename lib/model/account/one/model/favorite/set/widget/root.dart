import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/model/account/one/model/favorite/set/model/data.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';

class FavoritesWidgets {
  final Favorites favorites;

  FavoritesWidgets({@required this.favorites});

  Widget list(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ...favorites.list.map((favorite) {
              if (CheckFunctions.isItem(favorite.type))
                return favorite.widgets.buildToItem((context, iTem) => iTem.widgets.view(context));
              else if (CheckFunctions.isAccount(favorite.type)) {
                return favorite.widgets.buildToAccount((context, account) => account.widgets.accountDataWithNameAndImageBuilder(
                    context,
                    (context, account, name, image) => AccountTileReady(
                          account: account,
                          name: name,
                          image: image,
                        )));
              } else
                return Container();
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget grid(BuildContext context, {bool isAccount = false}) {
    if (favorites.list.isNotEmpty)
      return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 20 / 25, maxCrossAxisExtent: 500, crossAxisSpacing: 10, mainAxisSpacing: 10),
        shrinkWrap: true,
        cacheExtent: 50,
        itemCount: favorites.list.length,
        itemBuilder: (context, index) {
          var favorite = favorites.list[index];

          if (CheckFunctions.isItem(favorite.type))
            return favorite.widgets.buildToItem((context, iTem) => iTem.widgets.view(context));
          else if (CheckFunctions.isAccount(favorite.type)) {
            return favorite.widgets.buildToAccount(
              (context, account) => account.widgets.card(context),
            );
          } else
            return Container();
        },
      );
    else
      return Container();
  }
}
