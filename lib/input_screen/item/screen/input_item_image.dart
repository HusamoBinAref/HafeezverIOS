import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        EdgeInsets,
        MainAxisAlignment,
        Expanded,
        FloatingActionButton,
        FloatingActionButtonLocation,
        Icon,
        Icons,
        Key,
        Padding,
        Scaffold,
        StatelessWidget,
        Widget;

import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:provider/provider.dart';
import '../widget/row_title_and_tow_buttons.dart';
import '../widget/input_item_image_url_card.dart';

class InputItemImage extends StatelessWidget {
  const InputItemImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                tooltip: S.of(context).add_Item_Image_studio,
                heroTag: S.of(context).add_Item_Image_studio,
                onPressed: () {
                  controller.getImageFromPhone();
                },
                child: Icon(Icons.add_a_photo),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  ScreenRouting.myShowDialog(context,
                      child: InputItemImageUrlCard(
                        itemController: controller,
                      ));
                },
                child: Icon(Icons.add_link),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {
                  controller.imageType = "none";
                },
                child: Icon(Icons.no_photography),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            RowTitleAndTowButtons(
              title: "image",
              btnBackFunction: controller.backStep,
              btnNextFunction: controller.nextStep,
            ),
            Expanded(
              child: Column(
                children: [
                  controller.getImageWidget,
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
