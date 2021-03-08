import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/widget/rounded_container.dart';

import '../../one/model/image/one/model/image.dart';
import '../../one/model/data.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({
    Key key,
    @required this.item,
    this.itemImage,
  }) : super(key: key);

  final ITem item;
  final ItemImage itemImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Wrap(
            children: [
              Container(
                child: Padding(
                    padding: const EdgeInsets.all(5), child: itemImage.widgets.hero()),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      item.titles.editableStack(),
                      item.descriptions.editableStack(),
                      Stack(
                        children: <Widget>[
                          ContainerRounded(
                            margin: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            width: double.infinity,
                            elevation: 0,
                            borderRadius: 6,
                            top: 10,
                            child: Center(
                              child: item.user.widget(
                                (context, account) => account.widgets
                                    .tile(context, extraTag: item.reference.id),
                              ),
                            ),
                          ),
                          ContainerRounded(
                            margin: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            elevation: 0,
                            top: 0,
                            bottom: 0,
                            borderRadius: 15,
                            color: Theme.of(context).cardColor,
                            child: Text(
                              S.of(context).item_user,
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      item.widgets.createDateWidget(context),
                    ],
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
