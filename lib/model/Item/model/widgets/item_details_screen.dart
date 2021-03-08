import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';

import '../../one/model/image/one/model/image.dart';
import '../../one/model/data.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen(
      {Key key, @required this.item, this.itemImage, this.isSub = false})
      : super(key: key);

  final ITem item;
  final ItemImage itemImage;
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              item.user.widget(
                (context, account) =>
                    account.widgets.tile(context, extraTag: item.reference.id),
              ),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Hero(
                    tag: itemImage.reference.path + (isSub ? '/' : ''),
                    child: itemImage.widgets.image(),
                  ),
                ),
              ),
              // item.title.widget(
              //   (context, itemTitle) => itemTitle.editWidget(context: context),
              // ),
              item.descriptions.view(),
              Divider(),
              Container(
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(5),
                child: Text(
                  S.of(context).items_like,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
