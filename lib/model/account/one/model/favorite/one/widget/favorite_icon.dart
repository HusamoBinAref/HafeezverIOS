import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart'
    show BorderRadius, BuildContext, Center, CircleAvatar, Colors, EdgeInsets, Hero, Icon, IconButton, Icons, Key, StatelessWidget, Theme, Widget, required;

import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/title/set/api/get.dart';
import 'package:hafeez/model/account/one/model/favorite/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/set/api/get.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Favorite data;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: data.reference.path,
      child: RoundedCard(
        borderRadius: BorderRadius.circular(100),
        // shadowColor: Theme.of(context).primaryColorLight,
        color: Colors.transparent,
        // elevation: 2,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
          child: Center(
            child: IconButton(
              icon: GetAuthentication().isAuth
                  ? _iconBuilder(data.isFavorite, context: context)
                  : _iconBuilder(false, context: context),
              onPressed: () async => CheckFunctions.isItem(data.type)
                  ? openItemConfirmDialog(context)
                  : openConfirmDialog(context),
              tooltip: CheckFunctions.isItem(data.type)
                  ? S.of(context).favorite_Button
                  : S.of(context).follow_Button,
            ),
          ),
        ),
      ),
    );
  }

  Future openConfirmDialog(BuildContext context) async {
    if (GetAuthentication().isAuth) {
      var des = await GetDescriptions.build(data.to).currentDescriptionFuture;
      await AwesomeDialog(
        context: context,
        animType: AnimType.RIGHSLIDE,
        dialogType: DialogType.QUESTION,
        keyboardAware: true,
        dismissOnBackKeyPress: false,
        closeIcon: Icon(
          Icons.close,
          color: Theme.of(context).primaryColorLight,
        ),
        showCloseIcon: true,
        btnOkColor: Theme.of(context).primaryColorLight,
        btnOkText: S.of(context).ok,
        btnOkIcon: Icons.verified,
        title: data.isFavorite
            ? S.of(context).question_makeNotFavorite_shiekh
            : S.of(context).question_makeFavorite_shiekh,
        padding: const EdgeInsets.all(16.0),
        desc: des.text.isNotEmpty
            ? (des.text.length > 101 ? des.text.substring(1, 100) : des.text) +
                "..."
            : "",
        btnOkOnPress: () async => await data.modify.setData(),
      ).show();
    } else
      ScreenRouting.toSignInScreen(context);
  }

  Future openItemConfirmDialog(BuildContext context) async {
    if (GetAuthentication().isAuth) {
      var des = await GetItemTitles.build(data.to).currentDescriptionFuture;
      await AwesomeDialog(
        context: context,
        animType: AnimType.RIGHSLIDE,
        dialogType: DialogType.QUESTION,
        keyboardAware: true,
        dismissOnBackKeyPress: false,
        closeIcon: Icon(
          Icons.close,
          color: Theme.of(context).primaryColorLight,
        ),
        showCloseIcon: true,
        btnOkColor: Theme.of(context).primaryColorLight,
        btnOkText: S.of(context).ok,
        btnOkIcon: Icons.verified,
        title: data.isFavorite
            ? S.of(context).question_makeNotFavorite_item
            : S.of(context).question_makeFavorite_item,
        padding: const EdgeInsets.all(16.0),
        desc: des.text,
        btnOkOnPress: () async => await data.modify.setData(),
      ).show();
    } else
      ScreenRouting.toSignInScreen(context);
  }

  Icon _iconBuilder(bool status, {@required BuildContext context}) {
    if (CheckFunctions.isItem(data.type))
      return status
          ? Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            )
          : Icon(
              Icons.favorite_rounded,
              color: Theme.of(context).primaryColor,
            );
    else
      return status
          ? Icon(
              Icons.person,
              color: Colors.red,
            )
          : Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            );
  }
}
