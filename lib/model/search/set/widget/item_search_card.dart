import 'package:flutter/material.dart';

import '../../../Item/one/model/data.dart';
import '../../../public/cards/rounded_card.dart';
import '../../../../classes/routing/api/screens.dart';
import '../../../../classes/commends/key_words.dart';

class SearchItemCard extends StatelessWidget {
  const SearchItemCard({
    Key key,
    this.iTem,
  }) : super(key: key);

  final ITem iTem;
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      // elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: iTem.widgets.widgetBuilder((context, account, name, image, iTem,
              itemTitle, itemDescription, itemImage) =>
          iTem.video.widget((context, itemVideo) => InkWell(
                onTap: () {
                  if (KeyWords.itemKeyWords[1] == iTem.type)
                    ScreenRouting.toPostScreen(context, iTem, itemTitle,
                        itemDescription, itemImage, account, name, image);
                  else if (KeyWords.itemKeyWords[2] == iTem.type) {
                    ScreenRouting.toVideoScreen(
                        context,
                        iTem,
                        itemTitle,
                        itemDescription,
                        itemImage,
                        itemVideo,
                        account,
                        name,
                        image);
                  }
                },
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: iTem.type != KeyWords.itemKeyWords[0]
                          ? itemImage.widgets.hero(
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity)
                          : itemImage.widgets.hero(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ListTile(
                      leading: image.widgets
                          .circleImage(context, extraTag: iTem.reference.id),
                      title: name.widgets
                          .hero(context, extraTag: iTem.reference.id),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            itemTitle.widgets.hero(context),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}

// class SearchItemCard extends StatelessWidget {
//   const SearchItemCard({
//     Key key,
//     this.iTem,
//   }) : super(key: key);

//   final ITem iTem;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(5),
//       child: iTem.widgets.widgetBuilder(context, (context, account, name, image,
//           iTem, itemTitle, itemDescription, itemImage) {
//         return Container(
//           padding: EdgeInsets.only(bottom: 15, top: 5),
//           child: Column(
//             children: [
//               ListTile(
//                 onTap: () {
//                   if (KeyWords.itemKeyWords[1] == iTem.type)
//                     ScreenRouting.toPostScreen(context, iTem, itemTitle,
//                         itemDescription, itemImage, account, name, image);
//                 },
//                 leading: iTem.type != KeyWords.itemKeyWords[0]
//                     ? itemImage.widgets.hero(
//                         fit: BoxFit.cover,
//                         height: double.infinity,
//                         width: double.infinity)
//                     : itemImage.widgets.hero(),
//                 title: Row(
//                   children: [
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Card(
//                             color: Theme.of(context).primaryColorLight,
//                             child: Center(
//                               child: Text(
//                                 KeyWords.convert(context, iTem.type),
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .subtitle1
//                                     .copyWith(
//                                         color: Theme.of(context).primaryColor),
//                               ),
//                             ),
//                           ),
//                           Divider(),
//                           itemTitle.widgets.hero(context),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               ListTile(
//                 leading: image.widgets
//                     .circleImage(context, extraTag: iTem.reference.id),
//                 title: name.widgets.hero(context, extraTag: iTem.reference.id),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
