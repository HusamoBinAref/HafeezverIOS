import 'package:flutter/material.dart';

import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/widget/row_title_and_tow_buttons.dart';

import 'package:provider/provider.dart';

class InputItemRreview extends StatelessWidget {
  const InputItemRreview({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
//
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (controller.loadingLevel == 0) controller.uploadItem(context);
          },
          child: Icon(Icons.cloud_upload),
        ),
        body: (controller.loadingLevel != 0)
            ? Container(
                child: Center(
                    child: Text(
                        "Loading... it is on ${controller.loadingLevel.toString()} page ...")),
              )
            : Column(
                children: [
                  RowTitleAndTowButtons(
                    title: "Preview - " + controller.type,
                    btnBackFunction: controller.backStep,
                    // btnNextFunction: controller.nextStep,
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          controller.getImageWidget,
                          if (controller.titles.isNotEmpty)
                            Card(
                              color: Theme.of(context).primaryColorDark,
                              child: ListTile(
                                  title: Text(
                                S.of(context).titles,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                            ),
                          ...controller.getTitles(context, isEnable: false),
                          if (controller.descriptions.isNotEmpty)
                            Card(
                              color: Theme.of(context).primaryColorDark,
                              child: ListTile(
                                  title: Text(
                                S.of(context).descriptions,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                            ),
                          ...controller.getDescriptions(context,
                              isEnable: false),
                          if (controller.departments.isNotEmpty)
                            Card(
                              color: Theme.of(context).primaryColorDark,
                              child: ListTile(
                                  title: Text(
                                S.of(context).departments,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                            ),
                          ...controller.getDepartments(context),
                          if (controller.words.isNotEmpty)
                            Card(
                              color: Theme.of(context).primaryColorDark,
                              child: ListTile(
                                  title: Text(
                                S.of(context).words,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                            ),
                          ...controller.getWords(context),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
      );
    });
  }
}
