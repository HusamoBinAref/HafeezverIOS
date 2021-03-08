import 'package:flutter/material.dart'
    show BuildContext, Container, Widget, required;
import 'package:hafeez/classes/commends/key_words.dart';

import 'package:hafeez/model/Item/one/api/get.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/account/one/api/get.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/favorite/one/model/data.dart';

import 'favorite_icon.dart';

class FavoriteWidgets {
  final Favorite data;

  FavoriteWidgets({@required this.data});

  Widget buildToItem(Widget Function(BuildContext context, ITem iTem) builder) {
    if (CheckFunctions.isItem(data.type)) {
      return GetItem(reference: data.to)
          .widget((context, iTem) => builder(context, iTem));
    }
    return Container();
  }

  Widget buildToAccount(
      Widget Function(BuildContext context, Account account) builder) {
    if (CheckFunctions.isAccount(data.type)) {
      return GetAccount(reference: data.to)
          .widget((context, account) => builder(context, account));
    }
    return Container();
  }

  Widget icon(BuildContext context) {
    return FavoriteIcon(data: data);
  }
}
