import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
 
class EditItem extends StatelessWidget {
  const EditItem({
    Key key,
    @required this.iTem,
  }) : super(key: key);

  final ITem iTem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  S.of(context).titles,
                  style: Theme.of(context).textTheme.headline5,
                ),
                onTap: () {
                  iTem.titles.showEdittingScreen(context);
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
                  iTem.descriptions.showEdittingScreen(context);
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  S.of(context).departments,
                  style: Theme.of(context).textTheme.headline5,
                ),
                onTap: () {
                  iTem.references.showEdittingDepartmentsScreen(context);
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  S.of(context).words,
                  style: Theme.of(context).textTheme.headline5,
                ),
                onTap: () {
                  iTem.references.showEdittingWordsScreen(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
