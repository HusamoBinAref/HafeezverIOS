import 'package:flutter/material.dart' show BuildContext, Container, Widget;
import 'package:hafeez/generated/l10n.dart' show S;

import 'key_words.dart';

import '../../model/account/set/screen/accounts_screen_with_provider.dart';
import '../../model/Item/set/screen/items_screen_with_provider.dart';
import '../../model/department/set/widget/screen.dart';

class Selectors {
  static Widget main(int pageNo) {
    if (pageNo == 0)
      return AccountsScreenWithProvider(
        isSheikh: true,
      );
    else if (pageNo == 1)
      return DepartmentsScreen();
    else if (pageNo == 2)
      return ItemScreenWithProvider(
        type: KeyWords.itemKeyWords[1],
      );
    else if (pageNo == 3)
      return ItemScreenWithProvider(
        type: KeyWords.itemKeyWords[0],
      );
    else if (pageNo == 4)
      return ItemScreenWithProvider(
        type: KeyWords.itemKeyWords[2],
      );
    else if (pageNo == 5)
      return ItemScreenWithProvider (
        type: KeyWords.itemKeyWords[3],
      );
    else
      return Container();
  }

  static String title(
    BuildContext context,
    int pageNo,
  ) {
    if (pageNo == 0)
      return S.of(context).sheikhs;
    else if (pageNo == 1)
      return S.of(context).departments;
    else if (pageNo == 2)
      return S.of(context).posts;
    else if (pageNo == 3)
      return S.of(context).books;
    else if (pageNo == 4)
      return S.of(context).videos;
    else if (pageNo == 5)
      return S.of(context).voices;
    else
      return "";
  }
}
