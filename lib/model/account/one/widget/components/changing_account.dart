import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Center,
        CircularProgressIndicator,
        Column,
        EdgeInsets,
        FloatingActionButton,
        Form,
        FormState,
        GlobalKey,
        Icon,
        Icons,
        Key,
        Navigator,
        Padding,
        Scaffold,
        State,
        StatefulWidget,
        TextEditingController,
        TextFormField,
        Widget,
        required;

import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/account/one/model/data.dart';

class ChangingAccount extends StatefulWidget {
  ChangingAccount({
    Key key,
    @required this.account,
  }) : super(key: key);
  final Account account;

  @override
  _ChangingAccountState createState() => _ChangingAccountState();
}

class _ChangingAccountState extends State<ChangingAccount> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController editingController = TextEditingController();

  bool isUpdating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (key.currentState.validate()) {
            setState(() {
              isUpdating = true;
            });
            changingAccountFun().then((value) {
              if (value == "1")
                Navigator.of(context).pop();
              else
                setState(() {
                  isUpdating = false;
                });
            });
          }
        },
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (isUpdating)
                Center(child: CircularProgressIndicator())
              else
                TextFormField(
                  controller: editingController,
                  validator: (text) {
                    if (text.trim().isNotEmpty)
                      return null;
                    else
                      return "enter the id ";
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> changingAccountFun() async {
    var newAccount = await FirestoreSelectors.user
        .doc(editingController.value.text)
        .get()
        .then(Account.build);

    if (newAccount.snapshot.exists) {
      await newAccount.reference
          .set(widget.account.snapshot.data(), SetOptions(merge: true));

      for (var name in await widget.account.profile.names.reference
          .get()
          .then((value) => value.docs.toList())) {
        newAccount.reference
            .collection("Name")
            .doc(name.id)
            .set(name.data(), SetOptions(merge: true));
      }
      for (var description in await widget
          .account.profile.descriptions.reference
          .get()
          .then((value) => value.docs.toList())) {
        newAccount.reference
            .collection("Description")
            .doc(description.id)
            .set(description.data(), SetOptions(merge: true));
      }

      var image = await widget.account.profile.image.future;

      await newAccount.profile.image.reference
          .set(image.map, SetOptions(merge: true));

      return "1";
    } else
      return "0";
  }
}
