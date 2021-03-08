import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class EditDescriptionProfileWidget extends StatefulWidget {
  const EditDescriptionProfileWidget({
    Key key,
    @required this.description,
  }) : super(key: key);

  final DescriptionProfile description;
  @override
  _EditDescriptionProfileWidgetState createState() => _EditDescriptionProfileWidgetState();
}

class _EditDescriptionProfileWidgetState extends State<EditDescriptionProfileWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? Scaffold(
              body: Container(
                child:Center(child: Containers.waitting(context)),
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
                          widget.description.modify.setData(context).then((value) {
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColorLight.withOpacity(0.3))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Theme.of(context).primaryColorLight)),
                            labelText: S.of(context).account_name,
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                          ),
                          maxLength: 5000,
                          maxLines: 1,
                          controller: widget.description.controller,
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'name can not be empty...';
                            } else if (value == widget.description.text) {
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
            ),
    );
  }
}
