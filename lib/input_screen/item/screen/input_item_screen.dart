import 'package:flutter/material.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/screen/input_item_image.dart';
import 'package:provider/provider.dart';

import 'input_item_book.dart';
import 'input_item_department.dart';
import 'input_item_descriptions.dart';
import 'input_item_preview.dart';
import 'input_item_select_type.dart';
import 'input_item_titles.dart';
import 'input_item_words.dart';

class InputItemScreen2 extends StatelessWidget {
  InputItemScreen2({Key key}) : super(key: key);

  static buildScreen(BuildContext context) {
    ScreenRouting.navigator(
      context,
      child: ChangeNotifierProvider(
        create: (context) => ItemController(),
        builder: (context, _) {
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(child: InputItemScreen2()),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
      builder: (context, ItemController controller, _) {
        if (controller.step == 0)
          return InputItemSelectType();
        else if (controller.step == 10)
          return InputItemBook();
        else if (controller.step == 1)
          return InputItemTitles();
        else if (controller.step == 2)
          return InputItemDescriptions();
        else if (controller.step == 3)
          return InputItemDepartments();
        else if (controller.step == 4)
          return InputItemWords();
        else if (controller.step == 5)
          return InputItemImage();
        else if (controller.step == 6)
          return InputItemRreview();
        else
          return Container();
      },
    );
  }
}
