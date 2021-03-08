import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/image/one/widget/edit/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/model/report/widget/accounts/one/report_account_screen.dart';

import 'changing_account.dart';

class ButtonWithBorderRadius extends StatelessWidget {
  const ButtonWithBorderRadius({
    Key key,
    this.account,
    this.nameProfile,
    this.imageProfile,
  }) : super(key: key);

  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.all(10),
        child: GetAuthentication().showAccountStatus(
          context,
          (context, isManager, isSheikh, isOwner) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (isManager || isOwner)
                IconButton(
                  icon: Icon(
                    Icons.image,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return account.profile.image.widget(
                        (context, image) => ModifyImageWidget(
                          itemImage: image,
                        ),
                      );
                    }));
                  },
                  tooltip: "editting my image",
                ),
              if (isManager || isOwner)
                IconButton(
                  icon: Icon(
                    FontAwesome5.edit,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    ScreenRouting.edittingAccount(context, account);
                  },
                  tooltip: "editting my info",
                ),
              if (!isOwner)
                account.favoriteStatus.widget(builder: (context, favorite) {
                  return favorite.widgets.icon(context);
                }),
              IconButton(
                icon: Icon(
                  Icons.info,
                  color: Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return ChangingAccount(
                          account: account,
                        );
                      });
                },
                tooltip: "new message...",
              ),
              CircleAvatar(
                child: Card(
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          ReportAccontScreen.navigator(
                            context,
                            account,
                            nameProfile: nameProfile,
                            imageProfile: imageProfile,
                          );
                        },
                        icon: Icon(Icons.info)),
                  ),
                ),
              ),
            ],
          ),
          reference: account.reference,
        ));
  }
}

class ButtonWithBorderRadiusColumn extends StatelessWidget {
  const ButtonWithBorderRadiusColumn({
    Key key,
    this.account,
    this.nameProfile,
    this.imageProfile,
  }) : super(key: key);

  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;

  @override
  Widget build(BuildContext context) {
    return GetAuthentication().showAccountStatus(
      context,
      (context, isManager, isSheikh, isOwner) => Column(
        children: [
          if (isManager || isOwner)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: Icon(
                    Icons.image,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return account.profile.image.widget(
                        (context, image) => ModifyImageWidget(
                          itemImage: image,
                        ),
                      );
                    }));
                  },
                  tooltip: "editting my image",
                ),
              ),
            ),
          if (isManager || isOwner)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    // FontAwesome5.edit,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  onPressed: () {
                    ScreenRouting.edittingAccount(context, account);
                  },
                  tooltip: "editting my info",
                ),
              ),
            ),
          if (!isOwner)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  account.favoriteStatus.widget(builder: (context, favorite) {
                return favorite.widgets.icon(context);
              }),
            ),
          if (account.isSheikh)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        ReportAccontScreen.navigator(
                          context,
                          account,
                          nameProfile: nameProfile,
                          imageProfile: imageProfile,
                        );
                      },
                      icon: Icon(Icons.info)),
                ),
              ),
            ),
        ],
      ),
      reference: account.reference,
    );
  }
}
