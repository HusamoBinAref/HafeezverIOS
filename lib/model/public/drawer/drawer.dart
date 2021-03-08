import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart'
    show
        Brightness,
        BuildContext,
        Colors,
        Column,
        Container,
        Divider,
        Expanded,
        Icon,
        Icons,
        Key,
        ListTile,
        MaterialPageRoute,
        Navigator,
        SafeArea,
        SingleChildScrollView,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        showModalBottomSheet;
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/model/authentication/screen/ChooseAccountType.dart';
import 'package:hafeez/model/language/set/widget/screen.dart';
import 'package:hafeez/model/report/screen/report.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: GetAuthentication().streamBuilder(
          (context, auth) {
            bool isAuth = auth != null;
            return Column(
              children: [
                if (isAuth)
                  GetAuthentication().currentUser.account.widget(
                      (context, account) =>
                          account.widgets.tile(context, extraTag: '_')),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (isAuth) Divider(),
                        if (isAuth)
                          GetAuthentication().accountUser(
                            (context, account) => ListTile(
                                onTap: () {
                                  account.widgets.goFavoritesScreen(context);
                                },
                                leading: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  S.of(context).favorite_Button,
                                  style: Theme.of(context).textTheme.subtitle1,
                                )),
                          ),
                        ListTile(
                          onTap: () {
                            ScreenRouting.toSearchItemScreen(context);
                          },
                          leading: Icon(
                            Icons.search,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          title: Text(
                            S.of(context).search,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return LanguageScreen();
                              },
                            );
                          },
                          leading: Icon(
                            Icons.translate,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          title: Text(
                            S.of(context).settings_languages,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            if (Theme.of(context).brightness ==
                                Brightness.dark) {
                              DynamicTheme.of(context)
                                  .setBrightness(Brightness.light);
                            } else {
                              DynamicTheme.of(context)
                                  .setBrightness(Brightness.dark);
                            }
                          },
                          leading: Icon(
                            Icons.brightness_6,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          title: Text(
                            Theme.of(context).brightness == Brightness.dark
                                ? S.of(context).light_mode
                                : S.of(context).dark_mode,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),

                        // reports
                        ListTile(
                          leading: Icon(
                            Icons.dvr_outlined,
                            color: Theme.of(context).primaryColorLight,
                          ),
                          title: Text(
                            S.of(context).reports,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          onTap: () {
                            ReportScreen.navigator(context);
                          },
                        ),

                        // sign out
                        Divider(),
                        if (isAuth)
                          ListTile(
                              onTap: () {
                                GetAuthentication().signOut();
                              },
                              leading: Icon(
                                Icons.exit_to_app,
                                color: Theme.of(context).primaryColorLight,
                              ),
                              title: Text(
                                S.of(context).signOut,
                                style: Theme.of(context).textTheme.subtitle1,
                              )),

                        // sign up
                        if (!isAuth)
                          ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChooseAccountType();
                              }));
                            },
                            leading: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColorLight,
                            ),
                            title: Text(
                              S.of(context).signIn,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
