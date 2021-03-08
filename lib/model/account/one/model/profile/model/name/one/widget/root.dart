import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/public/cards/empty_card.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/widget/components/EdittingListTile.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/language/one/model/data.dart';

import 'edit.dart';
import 'name_with_language_icon.dart';

class NameProfileWidgets {
  final NameProfile data;

  NameProfileWidgets({@required this.data});

  Widget textWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).primaryColorLight,
          padding: const EdgeInsets.all(5),
          child: Text(
            S.of(context).account_name,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: hero(context),
        ),
      ],
    );
  }

  Widget editting(BuildContext context) {
    return EdittingListTile(
      title: data.text,
      iconData: Icons.person,
      subTitle: S.of(context).account_name,
      onTap: () {
        showBottomSheet(
            context: context,
            builder: (ctx) {
              return EditUserName(
                name: data,
                textEditingController: TextEditingController.fromValue(TextEditingValue(text: data.text)),
              );
            });
      },
    );
  }

  Widget hero(BuildContext context,
      {String extraTag = "",
      String extraText = "",
      TextOverflow overflow = TextOverflow.visible,
      int maxLines,
      double fontSize,
      bool isHero = true}) {
    var text = extraText != "" ? (extraText + " / " + data.text) : data.text;
    if (isHero)
      return Hero(
        tag: data.reference.path + "/" + extraTag,
        child: EmptyCard(
          child: Text(
            text,
            style: fontSize == null
                ? Theme.of(context).textTheme.subtitle1
                : Theme.of(context).textTheme.subtitle1.copyWith(fontSize: fontSize),
            overflow: overflow,
            maxLines: maxLines,
          ),
        ),
      );
    else
      return EmptyCard(
        child: Text(
          data.text,
          style: Theme.of(context).textTheme.subtitle1,
          overflow: overflow,
          maxLines: maxLines,
        ),
      );
  }

  Widget nameWithLanguageIcon(Language language) {
    return NameWithLanguageIconWidget(
      language: language,
      name: data,
    );
  }
}
