import 'package:flutter/material.dart'
    show
        BuildContext,
        Column,
        EdgeInsets,
        Expanded,
        FloatingActionButton,
        FloatingActionButtonLocation,
        Form,
        FormState,
        GlobalKey,
        Icon,
        Icons,
        InputDecoration,
        Key,
        MainAxisAlignment,
        Padding,
        Scaffold,
        StatelessWidget,
        TextFormField,
        Theme,
        Widget;
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/widget/input_item_book_url_card.dart';
import 'package:provider/provider.dart';

import '../widget/row_title_and_tow_buttons.dart';

class InputItemBook extends StatelessWidget {
  InputItemBook({
    Key key,
  }) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: buildColumnFloatingButtons(context, controller),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              RowTitleAndTowButtons(
                title: "Book",
                btnBackFunction: () => controller.step = 0,
                btnNextFunction: () {
                  if (formKey.currentState.validate()) controller.step = 1;
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.book.urlController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: S.of(context).add_video_field_hint,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 15),
                          labelText: "URL",
                          focusColor: Theme.of(context).primaryColorDark,
                          icon: Icon(Icons.link),
                        ),
                        validator: (value) {
                          if (value.trim().length < 20)
                            return "enter the url link , please ?";
                          else
                            return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Column buildColumnFloatingButtons(
      BuildContext context, ItemController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            tooltip: S.of(context).add_Item_Image_studio,
            heroTag: S.of(context).add_Item_Image_studio,
            onPressed: () {},
            child: Icon(Icons.add_a_photo),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            onPressed: () {
              ScreenRouting.myShowDialog(context,
                  child: InputItemBookUrlCard(
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
              controller.bookType = "none";
            },
            child: Icon(Icons.no_photography),
          ),
        ),
      ],
    );
  }
}
