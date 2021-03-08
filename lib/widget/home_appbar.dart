import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/screen/input_item_screen.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/widget/setting_menu.dart';
import '../classes/tools/placeholder.dart';
import '../classes/routing/api/screens.dart';

class TitleApp extends StatelessWidget {
  const TitleApp({Key key, this.style, this.extraText = ""}) : super(key: key);
  final TextStyle style;
  final String extraText;
  @override
  Widget build(BuildContext context) {
    return Text(
      // S.of(context).appName + (extraText != "" ? " - " : "") + extraText,
      S.of(context).appName,
      style: style,
    );
  }
}

class HomeAppBar {
  static title({String extraText}) => TitleApp(
        extraText: extraText,
      );

  static AppBar appbar(BuildContext context,
      {Function(int pageNo) onSelect, String extreText = ""}) {
    return AppBar(
      title: title(extraText: extreText),
      elevation: 0,
      centerTitle: true,
      // leading: Padding(
      //   padding: const EdgeInsets.all(4),
      //   child: GetAuthentication().accountUser((context, account) => account.widgets.imageButton(context)),
      // ),
      actions: <Widget>[
        GetAuthentication().accountUser((context, account) => Padding(
              padding: const EdgeInsets.all(10.0),
              child: account.widgets.imageButton(
                context,
              ),
            )),
        // GetAuthentication().accountUser((context, account) => Padding(
        //       padding: const EdgeInsets.all(10.0),
        //       child: IconButton(
        //         icon: Icon(
        //           Icons.report,
        //         ),
        //         onPressed: () {
        //           Navigator.push(context, MaterialPageRoute(builder: (context) {
        //             return AccountItems();
        //           }));
        //         },
        //       ),
        //     )),
        GetAuthentication().showIfEddingIsAllow(
          child: IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) {
                //   return AddButtonsScreen();
                // }));
                InputItemScreen2.buildScreen(context);
              }),
        ),
        // FieldsMenu(
        //   onSelect: onSelect,
        // ),
        // SettingMenu.settingsPopupMenu(context),
      ],
    );
  }

  static AppBar appbarAnonymuse(BuildContext context) {
    return AppBar(
      title: title(),
      elevation: 0,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            ScreenRouting.toSignInScreen(context);
          },
          child: Hero(
            tag: "hafeez/image",
            child: CircleAvatar(
              backgroundColor: Theme.of(context).dividerColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  PlaceHolderImages.userIcon,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
      actions: <Widget>[
        SettingMenu.settingsPopupMenu(context),
      ],
    );
  }
}
