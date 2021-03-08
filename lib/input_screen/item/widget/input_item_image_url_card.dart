import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Colors,
        Column,
        Container,
        EdgeInsets,
        Form,
        FormState,
        GlobalKey,
        Icon,
        Icons,
        InputDecoration,
        Key,
        MainAxisAlignment,
        Navigator,
        Padding,
        RaisedButton,
        Row,
        StatelessWidget,
        Text,
        TextFormField,
        Theme,
        Widget,
        required;
import 'package:hafeez/generated/l10n.dart';

import '../controller/item.dart';

class InputItemImageUrlCard extends StatelessWidget {
  InputItemImageUrlCard({
    Key key,
    @required this.itemController,
  }) : super(key: key);

  final ItemController itemController;
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 170,
        child: Form(
          key: keyForm,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: itemController.image.urlController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: S.of(context).add_video_field_hint,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    labelText: "URL",
                    focusColor: Theme.of(context).primaryColorDark,
                    icon: Icon(Icons.link),
                  ),
                  maxLengthEnforced: true,
                  validator: (value) {
                    if (value.trim().length < 20)
                      return "enter the url link , please ?";
                    else
                      return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                      color: Colors.green,
                      child: Text("Yes"),
                      onPressed: () {
                        if (keyForm.currentState.validate()) {
                          itemController.imageType = "url";
                          Navigator.pop(context);
                        }
                      },
                    ),
                    RaisedButton(
                      color: Colors.red,
                      child: Text("No"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
