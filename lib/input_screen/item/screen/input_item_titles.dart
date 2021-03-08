import 'package:flutter/material.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/widget/row_title_and_tow_buttons.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:provider/provider.dart';

class InputItemTitles extends StatelessWidget {
  const InputItemTitles({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
      if (controller.titles.isEmpty) {
        FirestoreSelectors.languages
            .doc(S.of(context).languageCode)
            .get()
            .then(Language.biuld)
            .then((value) => controller.addTitle(value));
      }

//
      return Scaffold(
        body: Scaffold(
          body: Column(
            children: [
              RowTitleAndTowButtons(
                title: S.of(context).titles,
                btnBackFunction: () {
                  if (controller.type == "Book")
                    controller.step = 10;
                  else
                    controller.backStep();
                },
                btnNextFunction: controller.nextStep,
              ),
              Expanded(
                child: Column(
                  children: controller.getTitles(context),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
