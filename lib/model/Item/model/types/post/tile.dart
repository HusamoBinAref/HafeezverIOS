import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/widget/read/post/post%20_details_screen.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

class ItemTileWidget extends StatelessWidget {
  const ItemTileWidget({
    Key key,
    this.item,
    this.extraTag = '',
  }) : super(key: key);
  final ITem item;
  final String extraTag;
  @override
  Widget build(BuildContext context) {
    return item.widgets.widgetBuilder((context, account, name, image, iTem,
            itemTitle, itemDescription, itemImage) =>
        ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PostDetailsScreen(
                  account: account,
                  nameProfile: name,
                  imageProfile: image,
                  iTem: item,
                  itemTitle: itemTitle,
                  itemImage: itemImage,
                  itemDescription: itemDescription,
                  extraTag: "/" + extraTag,
                );
              },
            ));
          },
          leading: itemImage.widgets.hero(extraTag: "/" + extraTag),
          title: itemTitle.widgets.hero(context, extraTag: "/" + extraTag),
          subtitle: itemDescription.widgets.hero(
            context,
            isEllipsis: true,
            extraTag: "/" + extraTag,
            maxLength: 2,
          ),
          trailing: Hero(
            tag: image.reference.path + '/' + extraTag,
            child: CacheImageWidget(
              assetImageTag: PlaceHolderImages.userIcon,
              imageUrl: image.url,
            ),
          ),
        ));
  }
}
