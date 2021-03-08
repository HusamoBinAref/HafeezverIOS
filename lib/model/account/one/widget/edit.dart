import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Card,
        Column,
        EdgeInsets,
        Key,
        ListTile,
        MaterialPageRoute,
        Navigator,
        Padding,
        Scaffold,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        CrossAxisAlignment,
        required;
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/data.dart';

class EditAccount extends StatelessWidget {
  const EditAccount({
    Key key,
    @required this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    S.of(context).names,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  onTap: () {
                    ScreenRouting.accountNames(context, account);
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(
                    S.of(context).descriptions,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  onTap: () {
                    ScreenRouting.accountDescriptions(context, account);
                  },
                ),
              ),
              if (account.isSheikh)
                Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      S.of(context).spacializations,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return account.referencesAll.specializationsList();
                      }));
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
