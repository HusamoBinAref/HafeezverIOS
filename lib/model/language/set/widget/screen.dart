import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/language/set/api/get.dart';

import 'package:hafeez/settings.dart' show Configrations;

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_languages),
      ),
      body: GetLanguages.build().widget((context, languages) {
        return Container(
          width: double.infinity,
          child: ListView.builder(
              cacheExtent: 8,
              itemCount: languages.languages.length,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (context, i) {
                var isSelected = languages.languages[i].languageCode == S.of(context).languageCode;
                return Card(
                  child: ListTile(
                    selectedTileColor: Theme.of(context).primaryColorLight,
                    onTap: () {
                      Configrations.changeLanguage(languages.languages[i].languageCode);
                    },
                    selected: isSelected,
                    leading:languages. languages[i].iconWidget(context),
                    title: Text(
                    languages.  languages[i].name,
                      style: isSelected
                          ? Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(color: Theme.of(context).primaryColor)
                          : Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Container(
                      child: Text(
                        isSelected ? S.of(context).settings_languages_isSelected : '',
                        style: isSelected
                            ? Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: Theme.of(context).primaryColor)
                            : Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                );
              }),
        );
      }),
    );
  }
}
