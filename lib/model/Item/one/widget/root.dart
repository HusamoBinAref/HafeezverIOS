import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/audio/model/data.dart';
import 'package:hafeez/model/Item/one/model/audio/widget/audio_card.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/Item/one/widget/read/post/post%20_details_screen.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/widget/edit/root.dart';
import 'package:hafeez/model/Item/one/widget/read/post/post_card.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/department/one/api/department.dart';
import 'package:hafeez/model/word/api/word.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';
import '../../model/widgets/item_details_screen.dart';
import 'read/video/video_card.dart';

class ItemWidgets {
  final ITem iTem;

  ItemWidgets({@required this.iTem});

  /// list Tile
  ///
  Widget listTile(BuildContext context) {
    return iTem.image.widget(
      (context, itemImage) {
        return Container(
          height: 130,
          width: 100,
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (
                    context2,
                  ) {
                    return ItemDetailScreen(
                      item: iTem,
                      itemImage: itemImage,
                    );
                  },
                ),
              );
            },
            child: GridTile(
              child: Container(
                height: 100,
                width: 100,
                child: CacheImageWidget(
                  imageUrl: itemImage.url,
                  width: double.infinity,
                  assetImageTag: PlaceHolderImages.bookImage,
                ),
              ),
              footer: Container(
                color: Theme.of(context).primaryColor,
                child: iTem.titles.widget(
                  (context, itemTitle) => Text(
                    itemTitle.text,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ///

  Widget departmentsWidget(
    BuildContext context,
  ) {
    return Wrap(
      // crossAxisAlignment: WrapCrossAlignment.center,_account
      alignment: WrapAlignment.start,
      spacing: 10,
      children: [
        if (iTem.references.departmentsReferences.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                S.of(context).departments,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        if (iTem.references.departmentsReferences.isNotEmpty)
          ...iTem.references.departmentsReferences
              .map(
                (department) => GetDepartment(reference: department).widget(
                  (context, _department) => _department.title.widget(
                    builder: (context, departmentTitle) => InkWell(
                      onTap: () {
                        _department.widgets.goToScreen(
                          context,
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          // horizontal: 10,
                          vertical: 5,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          departmentTitle.text,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        else if (iTem.references.departmentsReferences.isEmpty)
          Container(
            child: Center(child: Text("not founded..")),
          ),
        if (iTem.references.departmentsReferences.isNotEmpty) Divider(),
      ],
    );
  }

  Widget wordsWidget(
    BuildContext context,
  ) {
    return Wrap(
      // crossAxisAlignment: WrapCrossAlignment.center,_account
      alignment: WrapAlignment.start,
      spacing: 10,
      children: [
        if (iTem.references.wordsReferences.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                S.of(context).words,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        if (iTem.references.wordsReferences.isNotEmpty)
          ...iTem.references.wordsReferences
              .map(
                (word) => GetWord(reference: word).widget(
                  (context, _word) => _word.title.widget(
                    builder: (context, title) => Container(
                      margin: EdgeInsets.symmetric(
                        // horizontal: 10,
                        vertical: 5,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        title.text,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              )
              .toList()
        else if (iTem.references.wordsReferences.isEmpty)
          Container(
            child: Center(child: Text("not founded..")),
          ),
        if (iTem.references.wordsReferences.isNotEmpty) Divider(),
      ],
    );
  }

  Widget buttons(BuildContext context, {Function onTapEdit}) {
    return RoundedCard(
      color: Theme.of(context).primaryColorLight.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
      elevation: 0,
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          iTem.favoriteStatus.widget(builder: (context, favorite) {
            return favorite.widgets.icon(context);
          }),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
    );
  }

  Widget createDateWidget(BuildContext context) {
    return iTem.createString == ''
        ? Container()
        : Text(
            iTem.createString,
            style: Theme.of(context).textTheme.caption,
          );
  }

  Widget createDateHero(BuildContext context) {
    return Hero(
      tag: iTem.reference.path + "/createDate",
      child: createDateWidget(context),
    );
  }

  /// show bottom
  ///
  showEdittingScreen(BuildContext context, Function setState) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return EditItem(iTem: iTem);
      },
    )).then((value) => setState());
  }

  Widget widgetBuilder(
      Widget Function(
              BuildContext context,
              Account account,
              NameProfile name,
              ImageProfile image,
              ITem iTem,
              ItemTitle itemTitle,
              ItemDescription itemDescription,
              ItemImage itemImage)
          builder) {
    return iTem.image.widget((context, itemImage) => iTem.titles.widget(
        (context, title) => iTem.descriptions.widget((context, description) =>
            iTem.user.widget((context, account) => account.widgets
                    .accountDataWithNameAndImageBuilder(context,
                        (context, account, name, image) {
                  return builder(context, account, name, image, iTem, title,
                      description, itemImage);
                })))));
  }

  Widget videoBuilder(
      Widget Function(
              BuildContext context,
              Account account,
              NameProfile name,
              ImageProfile image,
              ITem iTem,
              ItemVideo itemVideo,
              ItemImage itemImage,
              ItemTitle itemTitle,
              ItemDescription itemDescription)
          builder) {
    return widgetBuilder((context, account, name, image, iTem, itemTitle,
            itemDescription, itemImage) =>
        iTem.video.widget((context, itemVideo) => builder(
            context,
            account,
            name,
            image,
            iTem,
            itemVideo,
            itemImage,
            itemTitle,
            itemDescription)));
  }

  Widget audioBuilder(
      Widget Function(
              BuildContext context,
              Account account,
              NameProfile name,
              ImageProfile image,
              ITem iTem,
              ItemAudio itemAudio,
              ItemImage itemImage,
              ItemTitle itemTitle,
              ItemDescription itemDescription)
          builder) {
    return widgetBuilder((context, account, name, image, iTem, itemTitle,
            itemDescription, itemImage) =>
        iTem.audio.widget((context, itemAudio) => builder(
            context,
            account,
            name,
            image,
            iTem,
            itemAudio,
            itemImage,
            itemTitle,
            itemDescription)));
  }

  Widget view(BuildContext context, {bool isAccount = false}) {
    if (iTem.type == KeyWords.itemKeyWords[1]) {
      return postCard();
    } else if (iTem.type == KeyWords.itemKeyWords[2]) {
      return videoCard(context);
    } else if (iTem.type == KeyWords.itemKeyWords[3]) {
      return audioCard();
    } else
      return Container();
  }

  Widget postCard() {
    return widgetBuilder(
      (context, account, name, image, iTem, itemTitle, itemDescription,
          itemImage) {
        return PostCard(
          account: account,
          imageProfile: image,
          nameProfile: name,
          iTem: iTem,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          itemImage: itemImage,
        );
      },
    );
  }

  Widget videoCard(BuildContext context) {
    return videoBuilder(
      (context, account, name, image, iTem, itemVideo, itemImage, itemTitle,
          itemDescription) {
        return VideoCard(
          iTem: iTem,
          itemImage: itemImage,
          itemVideo: itemVideo,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          account: account,
          imageProfile: image,
          nameProfile: name,
        );
      },
    );
  }

  Widget audioCard() {
    return audioBuilder(
      (context, account, name, image, iTem, itemAudio, itemImage, itemTitle,
          itemDescription) {
        return AudioCard(
          account: account,
          imageProfile: image,
          nameProfile: name,
          iTem: iTem,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          itemImage: itemImage,
          itemAudio: itemAudio,
        );
      },
    );
  }

  godetials(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          body: widgetBuilder((context, account, name, image, iTem, itemTitle,
                  itemDescription, itemImage) =>
              PostDetailsScreen(
                iTem: iTem,
                itemTitle: itemTitle,
                itemDescription: itemDescription,
                itemImage: itemImage,
                account: account,
                nameProfile: name,
                imageProfile: image,
              )),
        );
      },
    ));
  }
}
