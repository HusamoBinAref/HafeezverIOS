import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class EditUserDescription extends StatefulWidget {
  EditUserDescription({
    Key key,
    this.descriptoin,
    this.textEditingController,
  }) : super(key: key);
  final DescriptionProfile descriptoin;
  final TextEditingController textEditingController;

  @override
  _EditUserDescriptionState createState() => _EditUserDescriptionState();
}

class _EditUserDescriptionState extends State<EditUserDescription> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: isLoading
            ? Container(
                child: Center(child: Containers.waitting(context)),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.length == 0) {
                                      return 'name can not be empty...';
                                    } else if (value == widget.descriptoin.text) {
                                      return 'there is no changes...';
                                    } else if (value.length < 10) {
                                      return 'Name should be at least 10 charecters...';
                                    } else
                                      return null;
                                  },
                                  controller: widget.textEditingController,
                                  decoration: InputDecoration(
                                      labelText: S.of(context).description,
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
                                            widget.descriptoin.reference.set(
                                                {'text': widget.textEditingController.value.text},
                                                SetOptions(merge: true)).then((value) {
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
                                  maxLines: 30,
                                  maxLength: 500,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
      ),
    );
  }
}
