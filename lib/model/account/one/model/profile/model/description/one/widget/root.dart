import 'package:flutter/material.dart';
import 'package:hafeez/model/public/cards/empty_card.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/widget/components/EdittingListTile.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/model/language/one/model/data.dart';

import 'description_with_language_icon.dart';
import 'edit.dart';

class DescriptionProfileWidgets {
  final DescriptionProfile data;

  DescriptionProfileWidgets({@required this.data});

  Widget textWidget(BuildContext context) {
    return data.text == ""
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(5),
                child: Text(
                  S.of(context).description,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                child: Text(data.text,
                    style: Theme.of(context).textTheme.subtitle1),
              ),
            ],
          );
  }

  Widget editting(BuildContext context) {
    return EdittingListTile(
      isOwner: true,
      title: data.text,
      subTitle: S.of(context).description,
      iconData: Icons.description,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return EditUserDescription(
            descriptoin: data,
            textEditingController: TextEditingController.fromValue(
              TextEditingValue(
                text: data.text,
              ),
            ),
          );
        }));
      },
    );
  }

  Widget hero(
      {String extraTag = "",
      TextOverflow overflow = TextOverflow.visible,
      int maxLines}) {
    return DescriptionHero(
      data: data,
      extraTag: extraTag,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  Widget descriptionWithLanguageIcon(Language language) {
    return DescriptionWithLanguageIconWidget(
      language: language,
      description: data,
    );
  }
}

class DescriptionHero extends StatelessWidget {
  const DescriptionHero({
    Key key,
    @required this.data,
    this.extraTag = "",
    this.overflow = TextOverflow.visible,
    this.maxLines,
  }) : super(key: key);

  final String extraTag;
  final TextOverflow overflow;
  final int maxLines;
  final DescriptionProfile data;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: data.reference.path + "/" + extraTag,
      child: EmptyCard(
        child: Text(
          data.text,
          style: Theme.of(context).textTheme.subtitle1,
          overflow: overflow,
          maxLines: maxLines,
        ),
      ),
    );
  }
}
