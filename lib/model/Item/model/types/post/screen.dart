import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';

import '../../../one/widget/read/post/post _details_screen.dart';

class Post extends StatelessWidget {
  final ITem iTem;
  const Post({Key key, this.iTem}) : super(key: key);

  ///
  void onTap(BuildContext context, ItemTitle itemTitle, ItemDescription itemDescription,
      NameProfile nameProfile, ImageProfile imageProfile, Account account) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return PostDetailsScreen(
          iTem: iTem,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          account: account,
          nameProfile: nameProfile,
          imageProfile: imageProfile,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 300,
        child: iTem.titles.widget(
          (context, itemTitle) => iTem.descriptions.widget(
            (context, itemDescription) => iTem.user.widget(
              (context, account) => account.profile.image.widget(
                (context, imageProfile) => account.profile.names.currentName(
                  (context, nameProfile) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // الشيخ الناشر
                          AccountTileReady(
                            image: imageProfile,
                            name: nameProfile,
                            account: account,
                            extraTag: iTem.reference.id,
                            date: Hero(
                              tag: iTem.reference.path + "/createDate",
                              child: iTem.widgets.createDateWidget(context),
                            ),
                          ),
                          // عنوان المنشور
                          InkWell(
                            onTap: () => onTap(context, itemTitle, itemDescription, nameProfile,
                                imageProfile, account),
                            child: itemTitle.widgets.hero(context, isEllipsis: true),
                          ),

                          ///
                          Expanded(
                            child: InkWell(
                              onTap: () => onTap(context, itemTitle, itemDescription, nameProfile,
                                  imageProfile, account),
                              child: itemDescription.widgets.hero(context, isEllipsis: true),
                            ),
                          ),
                        ],
                      ),

                      //
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
