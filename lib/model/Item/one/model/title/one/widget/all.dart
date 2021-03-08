import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class ItemTitleWidgets {
  final ItemTitle title;

  ItemTitleWidgets({this.title});

  /// view
  ///
  view({BuildContext context}) => Text(
        title.text,
        style: Theme.of(context).textTheme.subtitle1,
      );

  /// edit
  ///

  Hero hero(BuildContext context,
      {bool isEllipsis = false, int maxLines = 0, String extraTag = ''}) {
    return Hero(
      tag: title.reference.path + extraTag,
      child: Text(
        title.text,
        style: Theme.of(context).textTheme.subtitle1,
        overflow: isEllipsis ? TextOverflow.ellipsis : null,
        maxLines: maxLines > 0 ? maxLines : null,
      ),
    );
  }

  Hero hero2(
    BuildContext context, {
    bool isEllipsis = false,
    String extraTag = '',
  }) {
    return Hero(
      tag: title.reference.path + extraTag,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).primaryColorLight,
          ),
          color: Theme.of(context).primaryColor,
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Text(
          title.text,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.justify,
          overflow: isEllipsis ? TextOverflow.ellipsis : null,
        ),
      ),
    );
  }

  void edittingWidget(
    BuildContext context, {
    String extraTag = '',
    Function refresh,
  }) {
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return _EditWidget(
          itemTitle: title,
        );
      },
    ));
  }

  Widget withLanguageIcon(BuildContext context, Language language) {
    return TitleWithIconLanguage(
      title: title,
      language: language,
    );
  }
}

class TitleWithIconLanguage extends StatelessWidget {
  const TitleWithIconLanguage({
    Key key,
    @required this.title,
    @required this.language,
  }) : super(key: key);

  final ItemTitle title;
  final Language language;
  @override
  Widget build(BuildContext context) {
    title.refreshController();
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            title.controller.value.text,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.justify,
          ),
          leading: language.iconWidget(context),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return _EditWidget(itemTitle: title);
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
    @required this.itemTitle,
  }) : super(key: key);

  final ItemTitle itemTitle;
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
                          widget.itemTitle.modify.setData(context).then((value) {
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: widget.itemTitle.controller,
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'name can not be empty...';
                          } else if (value == widget.itemTitle.text) {
                            return 'there is no changes...';
                          } else if (value.length < 10) {
                            return 'Name should be at least 10 charecters...';
                          } else
                            return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
