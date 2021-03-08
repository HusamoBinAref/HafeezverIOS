import 'package:flutter/material.dart'
    show
        AppBar,
        BuildContext,
        Builder,
        Colors,
        Dialog,
        EdgeInsets,
        Icon,
        Icons,
        MaterialPageRoute,
        Navigator,
        Padding,
        PopupMenuButton,
        PopupMenuEntry,
        PopupMenuItem,
        Row,
        SafeArea,
        Scaffold,
        SizedBox,
        Text,
        Theme,
        Widget,
        required,
        showDialog;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/audio/model/data.dart';
import 'package:hafeez/model/Item/one/model/audio/screen/audio_screen.dart';
import 'package:hafeez/model/Item/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/video/model/data.dart';
import 'package:hafeez/model/Item/one/widget/read/post/post%20_details_screen.dart';
import 'package:hafeez/model/Item/one/widget/read/video/video_details_screen.dart';
import 'package:hafeez/model/Item/set/controller/api/build_data.dart';
import 'package:hafeez/model/Item/set/controller/model/Voice.dart';
import 'package:hafeez/model/Item/set/controller/model/video.dart';
import 'package:hafeez/model/Item/set/controller/widget/root.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/account/one/widget/edit.dart';
import 'package:hafeez/model/authentication/screen/ChooseAccountType.dart';

import 'package:hafeez/model/search/set/widget/items_search_screen_v2.dart';

class ScreenRouting {
  static navigator(BuildContext context, {@required Widget child}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(body: child);
        },
      ),
    );
  }

  static navigatorReplacement(BuildContext context, {@required Widget child}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
              body: SafeArea(
            child: child,
          ));
        },
      ),
    );
  }

  static toSignInScreen(BuildContext context) {
    navigator(context, child: ChooseAccountType());
  }

  static myShowDialog(BuildContext context, {@required Widget child}) {
    return showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: child,
            );
          },
        ));
  }

  static void toHomeScreen(BuildContext context) {
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //   return Screens.home();
    // }));
  }

  static void toNewItemScreen(BuildContext context, String itemType,
      {VideoModel videoModel, VoiceModel voiceModel, String bookUrl}) {
    Navigator.push(context, MaterialPageRoute(
      builder: (contextPage) {
        return Scaffold(
            body: SafeArea(
          child: GetItemModel.model(itemType, (context, model) {
            return ItemAddWidgets(
              model: model,
            );
          }, videoModel: videoModel),
        ));
      },
    ));
  }

  static void toSearchItemScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (contextPage) {
        // return ItemsFutureSearch();
        return ItemsSearchScreen();
      },
    ));
  }

  static void toPostScreen(
      BuildContext context,
      ITem iTem,
      ItemTitle itemTitle,
      ItemDescription itemDescription,
      ItemImage itemImage,
      Account account,
      NameProfile nameProfile,
      ImageProfile imageProfile) {
    ScreenRouting.navigator(context,
        child: PostDetailsScreen(
          iTem: iTem,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          itemImage: itemImage,
          account: account,
          nameProfile: nameProfile,
          imageProfile: imageProfile,
          extraTag: iTem.reference.id,
        ));
  }

  static void toBookScreen(
      BuildContext context,
      ITem iTem,
      ItemTitle itemTitle,
      ItemDescription itemDescription,
      ItemImage itemImage,
      Account account,
      NameProfile nameProfile,
      ImageProfile imageProfile) {
    ScreenRouting.navigator(context,
        child: PostDetailsScreen(
          iTem: iTem,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          itemImage: itemImage,
          account: account,
          nameProfile: nameProfile,
          imageProfile: imageProfile,
          extraTag: iTem.reference.id,
        ));
  }

  static void toAudioScreen(
      BuildContext context,
      ITem iTem,
      ItemTitle itemTitle,
      ItemDescription itemDescription,
      ItemImage itemImage,
      ItemAudio itemAudio,
      Account account,
      NameProfile nameProfile,
      ImageProfile imageProfile) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return AudioScreen(
          iTem: iTem,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          itemImage: itemImage,
          itemAudio: itemAudio,
          account: account,
          nameProfile: nameProfile,
          imageProfile: imageProfile,
          extraTag: iTem.reference.id,
        );
      },
    ));
  }

  static void toVideoScreen(
      BuildContext context,
      ITem iTem,
      ItemTitle itemTitle,
      ItemDescription itemDescription,
      ItemImage itemImage,
      ItemVideo itemVideo,
      Account account,
      NameProfile nameProfile,
      ImageProfile imageProfile) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return VideoDetailsScreen(
          iTem: iTem,
          itemImage: itemImage,
          itemVideo: itemVideo,
          itemTitle: itemTitle,
          itemDescription: itemDescription,
          account: account,
          nameProfile: nameProfile,
          imageProfile: imageProfile,
        );
      },
    ));
  }

  static void edittingAccount(BuildContext context, Account account) {
    Navigator.push(context, MaterialPageRoute(
      builder: (ctx) {
        return EditAccount(account: account);
      },
    ));
  }

  static accountDescriptions(BuildContext context, Account account) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(S.of(context).descriptions),
          ),
          body: account.profile.descriptions.all(
              (context, language, description) =>
                  description.widgets.descriptionWithLanguageIcon(language)),
        ),
      );
    }));
  }

  static accountNames(BuildContext context, Account account) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(S.of(context).names),
          ),
          body: account.profile.names.all((context, language, name) =>
              name.widgets.nameWithLanguageIcon(language)),
        ),
      );
    }));
  }
}

class PopUpMenus {
  static PopupMenuButton addingPopupMenu(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.add_circle),
      onSelected: (int result) {
        if (result == 0)
          ItemAddWidgets.book(context);
        else if (result == 1)
          ItemAddWidgets.post(context);
        else if (result == 2)
          ItemAddWidgets.video(context);
        else if (result == 3) ItemAddWidgets.voice(context);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(FontAwesome.book),
              ),
              SizedBox(width: 10),
              Text(
                S.of(context).add_book,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(Icons.post_add),
              ),
              SizedBox(width: 10),
              Text(
                S.of(context).add_post,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(FontAwesome.youtube),
              ),
              SizedBox(width: 10),
              Text(
                S.of(context).add_video,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Icon(Icons.keyboard_voice),
              ),
              SizedBox(width: 10),
              Text(
                S.of(context).add_vioce,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ],
    );
  }
}
