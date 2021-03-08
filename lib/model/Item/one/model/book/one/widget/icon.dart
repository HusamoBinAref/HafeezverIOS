import 'package:flutter/material.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/Item/one/model/book/one/model/data.dart';
import 'package:hafeez/model/language/one/api/language.dart';
import 'package:hafeez/model/Item/one/model/book/one/widget/PDF_viewer.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';

class ItemBookIcon extends StatelessWidget {
  const ItemBookIcon({Key key, @required this.book}) : super(key: key);

  final ItemBook book;

  @override
  Widget build(BuildContext context) {
    return book.url != ""
        ? GetLanguage(
                reference: FirestoreSelectors.languages.doc(book.reference.id))
            .widget((context, language) {
            return InkWell(
              onTap: () => goToPDFScreen(context),
              child: RoundedCard(
                borderRadius: BorderRadius.circular(100),
                child: CacheImageWidget(
                  imageUrl: language.icon,
                  assetImageTag: PlaceHolderImages.languageIcon,
                ),
              ),
            );
          })
        : Container();
  }

  void goToPDFScreen(BuildContext context) {
    ScreenRouting.navigator(context,
        child: PDFViewerScreen(
          url: book.url,
        ));
  }
}
