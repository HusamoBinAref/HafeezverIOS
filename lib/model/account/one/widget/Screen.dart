import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/Details/detials_static.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/model/manament_status/ms_all.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/Item/set/widget/screen.dart';
import 'package:provider/provider.dart';

import 'account_profileData.dart';

class AccountProfile extends StatelessWidget {
  final Account account;
  final NameProfile nameProfile;
  final ImageProfile imageProfile;

  final String extraTag;

  const AccountProfile({
    Key key,
    @required this.account,
    this.imageProfile,
    this.nameProfile,
    this.extraTag = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(this.account.reference.path);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          centerTitle: true,
          title: Text(nameProfile.text),
          bottom: TabBar(
            // page tabs
            tabs: [
              Icon(
                DetailsCollections.shiekhs(context).iconData,
                size: 30,
              ),
              Icon(
                DetailsCollections.posts(context).iconData,
                size: 30,
              ),
              Icon(
                DetailsCollections.books(context).iconData,
                size: 30,
              ),
              Icon(
                DetailsCollections.videos(context).iconData,
                size: 30,
              ),
              Icon(
                DetailsCollections.voices(context).iconData,
                size: 30,
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              AccountProfileDataEditable2(
                account: account,
                nameProfile: nameProfile,
                imageProfile: imageProfile,
                extraTag: extraTag,
              ),
              Container(
                child: ChangeNotifierProvider<ManagementState>(
                  create: (context) => ManagementState(),
                  child: ItemsScreen(
                    type: KeyWords.itemKeyWords[1],
                    items: account.items.byTypes(KeyWords.posts),
                    isAccount: true,
                  ),
                ),
              ),
              Container(
                child: ChangeNotifierProvider<ManagementState>(
                  create: (context) => ManagementState(),
                  child: ItemsScreen(
                    type: KeyWords.itemKeyWords[0],
                    items: account.items.byTypes(KeyWords.books),
                    isAccount: true,
                  ),
                ),
              ),
              Container(
                child: ChangeNotifierProvider<ManagementState>(
                  create: (context) => ManagementState(),
                  child: ItemsScreen(
                    type: KeyWords.itemKeyWords[2],
                    items: account.items.byTypes(KeyWords.videos),
                    isAccount: true,
                  ),
                ),
              ),
              Container(
                child: ChangeNotifierProvider<ManagementState>(
                  create: (context) => ManagementState(),
                  child: ItemsScreen(
                    type: KeyWords.itemKeyWords[3],
                    items: account.items.byTypes(KeyWords.voices),
                    isAccount: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
