import 'package:flutter/material.dart'
    show
        BorderSide,
        BuildContext,
        Column,
        EdgeInsets,
        FontWeight,
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
        TextStyle,
        Theme,
        Widget;
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';

class EditItemDescription extends StatelessWidget {
  EditItemDescription({
    Key key,
    this.itemDescription,
    this.textEditingController,
  }) : super(key: key);
  final ItemDescription itemDescription;
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
                      return 'Description can not be empty...';
                    } else if (value == itemDescription.text) {
                      return 'there is no changes...';
                    } else if (value.length < 10) {
                      return 'Description should be at least 10 charecters...';
                    } else
                      return null;
                  },
                  controller: textEditingController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: S.of(context).item_description,
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.save,
                      ),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          itemDescription.reference.set({
                            'text': textEditingController.value.text
                          }).then((value) {
                            return Navigator.pop(context);
                          });
                        }
                      },
                    ),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
