import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show BorderSide, BuildContext, Center, Column, Container, EdgeInsets, Form, FormState, GlobalKey, Icon, IconButton, Icons, InputDecoration, Key, Navigator, OutlineInputBorder, Padding, State, StatefulWidget, TextEditingController, TextFormField, Theme, Widget;
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/widget/containers.dart';

class EditUserName extends StatefulWidget {
  EditUserName({
    Key key,
    this.name,
    this.textEditingController,
  }) : super(key: key);
  final NameProfile name;
  final TextEditingController textEditingController;

  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            child: Center(child: Containers.waitting(context)),
          )
        : Column(
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
                          } else if (value == widget.name.text) {
                            return 'there is no changes...';
                          } else if (value.length < 5) {
                            return 'Name should be at least 5 charecters...';
                          } else
                            return null;
                        },
                        controller: widget.textEditingController,
                        autofocus: true,
                        decoration: InputDecoration(
                            labelText: S.of(context).account_name,
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.save,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              onPressed: () {
                                if (formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = !isLoading;
                                  });
                                  widget.name.reference.set(
                                      {'text': widget.textEditingController.value.text},
                                      SetOptions(merge: true)).then((valueGiven) {
                                    Navigator.pop(context);
                                  }).catchError((givenError) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                }
                              },
                            ),
                            labelStyle: Theme.of(context).textTheme.headline6,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            hoverColor: Theme.of(context).primaryColorLight,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColorLight,
                              ),
                            ),
                            focusColor: Theme.of(context).primaryColorLight),
                        minLines: 1,
                        maxLines: 1,
                      ),
                    ),
                  )),
            ],
          );
  }
}
