import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

// import 'edit/root.dart';

class DescriptionWithLanguageIconWidget extends StatelessWidget {
  const DescriptionWithLanguageIconWidget({
    Key key,
    @required this.description,
    @required this.language,
  }) : super(key: key);

  final DescriptionProfile description;
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
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.justify,
          ),
          leading: language.iconWidget(context),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return EditDescriptionProfileWidget(
                  description: description,
                );
              },
            ));
          },
        ),
      ),
    );
  }
}

class EditDescriptionProfileWidget extends StatefulWidget {
  const EditDescriptionProfileWidget({
    Key key,
    @required this.description,
  }) : super(key: key);

  final DescriptionProfile description;
  @override
  _EditDescriptionProfileWidgetState createState() =>
      _EditDescriptionProfileWidgetState();
}

class _EditDescriptionProfileWidgetState
    extends State<EditDescriptionProfileWidget> {
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
                          widget.description.modify
                              .setData(context)
                              .then((value) {
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
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .primaryColorLight
                                        .withOpacity(0.3))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).primaryColorLight)),
                            labelText: S.of(context).description,
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                          ),
                          maxLength: 5000,
                          minLines: 3,
                          maxLines: 100,
                          controller: widget.description.controller,
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'name can not be empty...';
                            } else if (value == widget.description.text) {
                              return 'there is no changes...';
                            } else
                              return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
