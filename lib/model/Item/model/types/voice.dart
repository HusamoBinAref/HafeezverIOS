import 'package:flutter/material.dart';

import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/model/widgets/item_details_screen.dart';
import 'package:hafeez/model/account/one/widget/components/tile.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

class Voice extends StatefulWidget {
  final ITem iTem;
  const Voice({Key key, this.iTem}) : super(key: key);

  @override
  _VoiceState createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.iTem.image.widget(
        (context, itemImage) {
          return AspectRatio(
            aspectRatio: 16 / 16,
            child: Card(
              child: GridTile(
                header: Card(
                  margin: EdgeInsets.all(0),
                  child: widget.iTem.user.widget(
                    (context, _account) {
                      return _account.profile.names.currentName(
                        (context, _nameProfile) => _account.profile.image.widget(
                          (context, _imageProfile) {
                            return AccountTileReady(
                              account: _account,
                              name: _nameProfile,
                              image: _imageProfile,
                              extraTag: widget.iTem.reference.id,
                              date: Hero(
                                tag: widget.iTem.reference.path + "/createDate",
                                child: widget.iTem.widgets.createDateWidget(context),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (
                          context2,
                        ) {
                          return ItemDetailScreen(
                            item: widget.iTem,
                            itemImage: itemImage,
                          );
                        },
                      ),
                    );
                  },
                  child: Hero(
                    tag: itemImage.reference.path,
                    child: CacheImageWidget(
                      imageUrl: itemImage.url,
                      assetImageTag: PlaceHolderImages.voiceImage,
                    ),
                  ),
                ),
                footer: Card(
                  margin: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.iTem.titles.widget(
                          (context, itemTitle) => itemTitle.widgets.view(context: context),
                        ),
                      ),
                      if (GetAuthentication().isAuth) Divider(),
                      if (GetAuthentication().isAuth)
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavorite
                                    ? Theme.of(context).primaryColorLight
                                    : Theme.of(context).primaryColorLight.withOpacity(0.5),
                              ),
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              tooltip: 'favorite',
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.share,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              onPressed: () {},
                              tooltip: 'like',
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
