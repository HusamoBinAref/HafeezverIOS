import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/language/one/model/data.dart';

import '../../model/data.dart';

class TitleWidget extends StatefulWidget {
  final bool withDrawer;
  final ItemModel model;
  const TitleWidget({
    Key key,
    @required this.model,
    this.withDrawer = true,
  }) : super(key: key);

  @override
  _TitleWidgetState createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.withDrawer ? buildDrawer(widget.model) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.model.formKeys[0],
          child: SingleChildScrollView(
            child: Column(
              children: children(context, widget.model),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> children(BuildContext context, ItemModel itemController) {
    return [
      SizedBox(height: 10),
      Card(
        color: Theme.of(context).primaryColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2.0,
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: double.infinity,
          child: Text(
            S.of(context).add_Item_title,
            // "title",
            style: TextStyle(fontSize: 18.0, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      SizedBox(height: 10),
      ...(itemController.titleList.languages.map((title) {
        if (title.isSelected)
          return buildTextFormField(title, context);
        else
          return Container();
      })),
    ];
  }

  Drawer buildDrawer(ItemModel itemController) {
    return Drawer(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          itemCount: itemController.titleList.languages.length,
          itemBuilder: (context, index) {
            var language = itemController.titleList.languages[index];
            return language.card(context, (_language) {
              setState(() {
                language.toggleSelection();
              });
            });
          }),
    ));
  }

  Widget buildTextFormField(Language language, BuildContext context) {
    return TextFormField(
      maxLength: 250,
      minLines: 1,
      maxLines: 4,
      maxLengthEnforced: true,
      controller: language.textEditingController,
      decoration: InputDecoration(
        labelStyle: Theme.of(context).textTheme.subtitle1,
        labelText: language.name,
        focusColor: Theme.of(context).primaryColorLight,
        icon: CircleAvatar(
          maxRadius: 20,
          child: language.iconWidget(context),
        ),
      ),
      validator: (text) {
        if (text.length < 10)
          return S.of(context).ten_cher_or_more;
        else
          return null;
      },
    );
  }
}
