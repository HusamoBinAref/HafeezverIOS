import 'package:flutter/material.dart'
    show
        BorderSide,
        BuildContext,
        Column,
        EdgeInsets,
        Form,
        FormState,
        GlobalKey,
        Icon,
        IconButton,
        Icons,
        InputDecoration,
        Key,
        Navigator,
        OutlineInputBorder,
        Padding,
        StatelessWidget,
        TextEditingController,
        TextFormField,
        Theme,
        Widget;
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';

class EditItemTitle extends StatelessWidget {
  EditItemTitle({
    Key key,
    this.itemTitle,
    this.textEditingController,
  }) : super(key: key);
  final ItemTitle itemTitle;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: true,
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'name can not be empty...';
                    } else if (value == itemTitle.text) {
                      return 'there is no changes...';
                    } else if (value.length < 10) {
                      return 'Name should be at least 10 charecters...';
                    } else
                      return null;
                  },
                  controller: textEditingController,
                  decoration: InputDecoration(
                    labelText: S.of(context).account_name,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.save, color: Theme.of(context).primaryColorLight),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          itemTitle.reference
                              .set({'text': textEditingController.value.text}).then((value) {
                            return Navigator.pop(context);
                          });
                        }
                      },
                    ),
                    labelStyle: Theme.of(context).textTheme.headline5,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                  minLines: 1,
                  maxLines: 1,
                ),
              ),
            )),
      ],
    );
  }
}
