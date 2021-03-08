import 'package:flutter/material.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/favorite/set/widget/screen.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';

import 'Screen.dart';
import 'components/account_card_widget.dart';
import 'components/tile.dart';

class AccountWidgets {
  final Account data;

  AccountWidgets({@required this.data});

  goToScreenProfile(BuildContext context,
      {@required NameProfile nameProfile,
      @required ImageProfile imageProfile,
      String extraTag = ''}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return AccountProfile(
          account: data,
          imageProfile: imageProfile,
          nameProfile: nameProfile,
          extraTag: extraTag,
        );
      }),
    );
  }

  Widget tile(
    BuildContext context, {
    String extraTag = '',
  }) {
    return accountDataWithNameAndImageBuilder(context,
        (context, account, name, image) {
      return AccountTileReady(
        account: data,
        name: name,
        image: image,
        extraTag: extraTag,
      );
    });
  }

  Widget tileTile(
    BuildContext context, {
    String extraTag = '',
  }) {
    return accountDataWithNameAndImageBuilder(context,
        (context, account, name, image) {
      return RoundedCard(
        elevation: 0,
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(0),
        child: ListTile(
          onTap: () {
            account.widgets.goToScreenProfile(
              context,
              imageProfile: image,
              nameProfile: name,
              extraTag: extraTag,
            );
          },
          leading: image.widgets.circleImage(
            context,
            extraTag: extraTag,
          ),
          title: name.widgets.hero(
            context,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            extraTag: extraTag,
          ),
          trailing: account.favoriteStatus.widget(
            builder: (context, favorite) => favorite.widgets.icon(context),
          ),
        ),
      );
    });
  }

  Widget imageButton(BuildContext context, {extraTag = "home"}) {
    return accountDataWithNameAndImageBuilder(context,
        (context, account, name, image) {
      return GestureDetector(
        onTap: () {
          goToScreenProfile(context,
              imageProfile: image, nameProfile: name, extraTag: extraTag);
        },
        child:
            image.widgets.circleImage(context, extraTag: extraTag, radius: 150),
      );
    });
  }

  Widget homeIcon(
    BuildContext context,
  ) {
    return accountDataWithNameAndImageBuilder(context,
        (context, account, name, image) {
      return GestureDetector(
        onTap: () {
          goToScreenProfile(
            context,
            imageProfile: image,
            nameProfile: name,
          );
        },
        child: image.widgets.homeCircleImage(
          context,
        ),
      );
    });
  }

  Widget accountDataWithNameAndImageBuilder(
      BuildContext context,
      Function(BuildContext context, Account account, NameProfile name,
              ImageProfile image)
          builder) {
    return data.profile.widgets.nameAndImageBuilder(
        (context, name, image) => builder(context, data, name, image));
  }

  Widget card(BuildContext context) {
    return RoundedCard(
      borderRadius: BorderRadius.circular(20),
      child: data.profile.widgets
          .nameAndImageBuilder((context, name, image) => AccountCardWidget(
                account: data,
                name: name,
                image: image,
              )),
    );
  }

  goFavoritesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return data.favorites.widget(
              (context, favorites) => FavoritesScreen(favorites: favorites));
        },
      ),
    );
  }
}
