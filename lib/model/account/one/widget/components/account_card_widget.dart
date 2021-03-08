import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';

class AccountCardWidget extends StatelessWidget {
  final Account account;
  final NameProfile name;
  final ImageProfile image;

  const AccountCardWidget({
    Key key,
    @required this.account,
    @required this.name,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        account.widgets.goToScreenProfile(
          context,
          imageProfile: image,
          nameProfile: name,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                // image
                image.widgets.hero(
                  context,
                  width: double.infinity,
                ),

                // name
                Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                          color: Theme.of(context).cardColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          alignment: Alignment.center,
                          child: name.widgets.hero(context, maxLines: 1,overflow: TextOverflow.ellipsis)),
                    ]),

                // button favorite
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: account.favoriteStatus.widget(
                        builder: (context, favorite) {
                          return favorite.widgets.icon(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
