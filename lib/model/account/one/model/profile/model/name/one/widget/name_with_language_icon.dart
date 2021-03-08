
import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/language/one/model/data.dart';

import 'edit/root.dart';

class NameWithLanguageIconWidget extends StatelessWidget {
  const NameWithLanguageIconWidget({
    Key key, 
    @required this.name,
    @required this.language,
  }) : super(key: key);

  final NameProfile name;
  final Language language;
  @override
  Widget build(BuildContext context) {
    name.refreshController();
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          title: Text(
            name.controller.value.text,
            style: Theme.of(context).textTheme.subtitle1,
            textAlign: TextAlign.justify,
          ),
          leading: language.iconWidget(context),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return EditNameProfileWidget(name: name);
              },
            ));
          },
        ),
      ),
    );
  }
}
