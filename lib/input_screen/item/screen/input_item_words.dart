import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/widget/row_title_and_tow_buttons.dart';
import 'package:hafeez/model/word/words.dart';
import 'package:provider/provider.dart';

class InputItemWords extends StatelessWidget {
  const InputItemWords({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
      return Scaffold(
        body: Column(
          children: [
            RowTitleAndTowButtons(
              title: S.of(context).words,
              btnBackFunction: controller.backStep,
              btnNextFunction: controller.nextStep,
            ),
            Expanded(
              child: GetWords.build.widget((context, words) {
                return ListView.builder(
                  itemCount: words.words.length,
                  itemBuilder: (context, index) {
                    var word = words.words[index];
                    var isSelected = controller.words.contains(word.reference);
                    return Card(
                      color: isSelected
                          ? Theme.of(context).primaryColorDark
                          : null,
                      child: ListTile(
                        onTap: () {
                          if (isSelected)
                            controller.deleteWord(word.reference);
                          else
                            controller.addWord(word.reference);
                        },
                        selected: isSelected,
                        title: word.title.widget(
                          builder: (context, title) {
                            return Text(
                              title.text,
                              style: TextStyle(
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context).primaryColorDark),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
