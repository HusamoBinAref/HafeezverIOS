import 'package:flutter/material.dart';
import 'package:hafeez/Details/detials_static.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/controller/title.dart';
import 'package:hafeez/model/Item/set/controller/api/video.dart';
import 'package:hafeez/model/language/one/api/language.dart';
import 'package:provider/provider.dart';

import '../widget/input_item_button_type.dart';

class InputItemSelectType extends StatelessWidget {
  const InputItemSelectType({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
      return Scaffold(
        body: Column(
          children: [
            Card(
              color: Theme.of(context).primaryColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Center(
                    child: Text(S.of(context).element_type,
                        style:
                            TextStyle(color: Theme.of(context).primaryColor))),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                children: [
                  InputItemButtonType(
                    text: DetailsCollections.post(context).text,
                    icon: DetailsCollections.post(context).iconData,
                    onPressed: () {
                      controller.type = KeyWords.posts;
                      controller.nextStep();
                    },
                  ),
                  InputItemButtonType(
                    text: DetailsCollections.book(context).text,
                    icon: DetailsCollections.book(context).iconData,
                    onPressed: () {
                      controller.type = KeyWords.books;
                      controller.step = 10;
                    },
                  ),
                  InputItemButtonType(
                    text: DetailsCollections.video(context).text,
                    icon: DetailsCollections.video(context).iconData,
                    onPressed: () async {
                      var videoData =
                          await VideoFunctions.addVideoLink2(context);

                      if (videoData != null) {
                        controller.type = KeyWords.videos;
                        // add title
                        controller.titles.add(TitleController(
                          language: await GetLanguage(
                                  reference: FirestoreSelectors.languages
                                      .doc(S.of(context).languageCode))
                              .future,
                          controller:
                              TextEditingController(text: videoData.title),
                        ));

                        // add image
                        controller.imageUrl = videoData.thumbnailUrl;

                        // add video url
                        controller.videoUrl = videoData.videoUrl;

                        controller.nextStep();
                      }
                    },
                  ),
                  InputItemButtonType(
                    text: DetailsCollections.voice(context).text,
                    icon: DetailsCollections.voice(context).iconData,
                    onPressed: () {
                      controller.type = KeyWords.voices;
                      controller.nextStep();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
