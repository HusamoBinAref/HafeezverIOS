import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show
        Brightness,
        BuildContext,
        FutureBuilder,
        Locale,
        MaterialApp,
        SafeArea,
        Scaffold,
        StatelessWidget,
        ValueListenableBuilder,
        ValueNotifier,
        Widget,
        WidgetsFlutterBinding,
        runApp;
import 'package:flutter_localizations/flutter_localizations.dart'
    show
        GlobalCupertinoLocalizations,
        GlobalMaterialLocalizations,
        GlobalWidgetsLocalizations;

// import 'package:syncfusion_localizations/syncfusion_localizations.dart'
//     show SfGlobalLocalizations;
import 'generated/l10n.dart' show S;

import 'main_screen.dart';
import 'settings.dart';
import 'theme/theme_data_dark.dart';
import 'theme/theme_data_light.dart';
import 'theme/title.dart';

Future<void> main() => MyApp.main();

class MyApp extends StatelessWidget {
  static Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) {
          if (brightness == Brightness.light) {
            return ThemeDataLight().theme;
          } else {
            return ThemeDataDark().theme;
          }
        },
        themedWidgetBuilder: (context, theme) {
          return FutureBuilder<ValueNotifier<Locale>>(
              initialData: ValueNotifier(null),
              future: Configrations.getDefaultLanguage,
              builder: (context, snapshotLanguage) {
                return ValueListenableBuilder(
                    valueListenable: snapshotLanguage.data,
                    builder: (context, Locale _language, _) {
                      return MaterialApp(
                        title: Titles.projectTitle(
                            (_language ?? Locale('ar', '')).languageCode),
                        theme: theme,
                        debugShowCheckedModeBanner: false,
                        locale: _language,
                        localizationsDelegates: [
                          S.delegate,
                          GlobalMaterialLocalizations.delegate,
                          GlobalWidgetsLocalizations.delegate,
                          GlobalCupertinoLocalizations.delegate,
                          // SfGlobalLocalizations.delegate,
                        ],
                        supportedLocales: S.delegate.supportedLocales,
                        home: Scaffold(
                          body: SafeArea(
                            child: Home(),
                          ),
                        ),
                      );
                    });
              });
        });
  }
}
