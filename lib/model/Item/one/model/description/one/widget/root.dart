import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class ItemDescriptionWidgets {
  final ItemDescription description;

  ItemDescriptionWidgets({@required this.description});

  Hero hero(BuildContext context, {bool isEllipsis = false, int maxLength = 0, String extraTag = ''}) {
    return Hero(
      tag: description.reference.path + '/' + extraTag,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        padding: const EdgeInsets.all(10),
        child: Text(
          description.text,
          style: Theme.of(context).textTheme.subtitle2.copyWith(color: Theme.of(context).primaryColorLight),
          overflow: isEllipsis ? TextOverflow.ellipsis : null,
          maxLines: maxLength > 0 ? maxLength : null,
        ),
      ),
    );
  }

  Hero hero2(BuildContext context, {bool isEllipsis = false, String extraTag = ''}) {
    return Hero(
      tag: description.reference.path + '/' + extraTag,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
          ),
          color: Theme.of(context).primaryColor,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Text(
          description.text,
          style: Theme.of(context).textTheme.subtitle1,
          textAlign: TextAlign.justify,
          overflow: isEllipsis ? TextOverflow.fade : null,
          maxLines: isEllipsis ? 4 : null,
        ),
      ),
    );
  }

  void edittingWidget(
    BuildContext context, {
    @required ItemDescription itemDescription,
    String extraTag = '',
  }) {
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return _EditWidget(
          itemDescription: itemDescription,
        );
      },
    ));
  }

  Widget withLanguageIcon(BuildContext context, Language language) {
    return DescriptionWithIconLanguage(
      description: description,
      language: language,
    );
  }
}

class DescriptionWithIconLanguage extends StatelessWidget {
  const DescriptionWithIconLanguage({
    Key key,
    @required this.description,
    @required this.language,
  }) : super(key: key);

  final ItemDescription description;
  final Language language;
  @override
  Widget build(BuildContext context) {
    description.refreshController();
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            description.controller.value.text,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.justify,
          ),
          leading: language.iconWidget(context),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return _EditWidget(itemDescription: description);
              },
            ));
          },
        ),
      ),
    );
  }
}

class _EditWidget extends StatefulWidget {
  const _EditWidget({
    Key key,
    @required this.itemDescription,
  }) : super(key: key);

  final ItemDescription itemDescription;

  @override
  __EditWidgetState createState() => __EditWidgetState();
}

class __EditWidgetState extends State<_EditWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Scaffold(
              body: Container(
                child: Center(child: Containers.waitting(context)),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          widget.itemDescription.modify.setData(context).then((value) {
                            Navigator.pop(context);
                          }).catchError((givenError) {
                            setState(() {
                              isLoading = !isLoading;
                            });
                          });
                        }
                      })
                ],
              ),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: widget.itemDescription.controller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        gapPadding: 1,
                        borderSide: BorderSide(color: Theme.of(context).primaryColorLight.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 1,
                        borderSide: BorderSide(color: Theme.of(context).primaryColorLight),
                      ),
                      // labelStyle: Theme.of(context).textTheme.subtitle1,
                    ),
                    minLines: 3,
                    maxLines: 100,
                    maxLengthEnforced: true,
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'name can not be empty...';
                      } else if (value == widget.itemDescription.text) {
                        return 'there is no changes...';
                      } else if (value.length < 10) {
                        return 'Name should be at least 10 charecters...';
                      } else
                        return null;
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
