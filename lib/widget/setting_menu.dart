import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/language/set/widget/screen.dart';

class SettingMenu {
  static showScreen(BuildContext context, Widget result) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return result;
      },
    );
  }

  static PopupMenuButton settingsPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.settings_applications),
      onSelected: (int result) {
        // languages
        if (result == 1)
          showScreen(
            context,
            LanguageScreen(),
          );

        // languages
        if (result == 2) {
          if (Theme.of(context).brightness == Brightness.dark) {
            DynamicTheme.of(context).setBrightness(Brightness.light);
          } else {
            DynamicTheme.of(context).setBrightness(Brightness.dark);
          }
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: Row( 
            children: [
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(Icons.translate),
              ),
              SizedBox(width: 10),
              Text(
                S.of(context).settings_languages,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(
                  Icons.brightness_6,
                  color: Theme.of(context).primaryColorLight,
                ),
              ),
              SizedBox(width: 10),
              Text(
                Theme.of(context).brightness == Brightness.dark ? S.of(context).light_mode : S.of(context).dark_mode,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
