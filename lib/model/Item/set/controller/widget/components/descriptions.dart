import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import '../../model/data.dart';

class DescriptionWidget extends StatefulWidget {
  final bool withDrawer;
  final ItemModel model;
  const DescriptionWidget({
    Key key,
    this.withDrawer = true,
    @required this.model,
  }) : super(key: key);

  @override
  _DescriptionWidgetState createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.withDrawer ? buildDrawer(widget.model) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.model.formKeys[1],
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
            S.of(context).add_Item_description,
            // "title",
            style: TextStyle(fontSize: 18.0, color: Theme.of(context).primaryColor),
          ),
        ),
      ),
      SizedBox(height: 10),
      ...(itemController.descriptionList.languages.map((description) {
        if (description.isSelected)
          return buildTextFormField(description, context);
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
          itemCount: itemController.descriptionList.languages.length,
          itemBuilder: (context, index) {
            var language = itemController.descriptionList.languages[index];
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
      maxLength: 400000,
      minLines: 1,
      maxLines: 30,
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
