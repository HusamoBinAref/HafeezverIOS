import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        BorderSide,
        Center,
        EdgeInsets,
        FontWeight,
        Icon,
        IconButton,
        Icons,
        InputDecoration,
        ListView,
        MaterialPageRoute,
        Navigator,
        OutlineInputBorder,
        Padding,
        SafeArea,
        Scaffold,
        Text,
        TextEditingController,
        TextEditingValue,
        TextFormField,
        Theme,
        showBottomSheet;
import 'package:flutter/widgets.dart'
    show StreamBuilder, BuildContext, Widget, Container, TextStyle;
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/title/one/api/get.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';
import 'package:hafeez/model/Item/one/model/title/one/widget/Editting_Title.dart';
import 'package:hafeez/model/language/set/api/get.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

import '../../one/model/data.dart';

class GetItemTitles {
  static GetItemTitles build(DocumentReference reference) {
    return GetItemTitles(reference: reference.collection('Title'));
  }

  final CollectionReference reference;
  final String defaultLanguage;
  final currentLanguageCode = S.current.languageCode;
  GetItemTitles({
    this.reference,
    this.defaultLanguage = 'ar',
  });

  Future<ItemTitle> get future async {
    var title =
        await reference.doc(currentLanguageCode).get().then((_itemTitle) {
      if (_itemTitle.exists)
        return ItemTitle.toTitle(_itemTitle);
      else
        return null;
    });

    if (title == null)
      title = await reference.doc(defaultLanguage).get().then((_itemTitle) {
        if (_itemTitle.exists)
          return ItemTitle.toTitle(_itemTitle);
        else
          return ItemTitle(
            reference: reference.doc(currentLanguageCode),
            map: {},
          );
      });

    return title;
  }

  Stream<ItemTitle> get stream {
    return reference.doc(currentLanguageCode).snapshots().map((_itemTitle) {
      if (_itemTitle.exists)
        return ItemTitle.toTitle(_itemTitle);
      else
        return null;
    });
  }

  Stream<ItemTitle> get defaultStream {
    return reference.doc(defaultLanguage).snapshots().map((_itemTitle) {
      if (_itemTitle.exists)
        return ItemTitle.toTitle(_itemTitle);
      else
        return ItemTitle(
          reference: reference.doc(currentLanguageCode),
          map: {},
        );
    });
  }

// Future
  Future<ItemTitle> get oneFuture {
    return reference.doc(currentLanguageCode).get().then((_itemDescription) {
      if (_itemDescription.exists)
        return ItemTitle.toTitle(_itemDescription);
      else
        return null;
    });
  }

  Future<ItemTitle> get defaultFuture {
    return reference.doc(defaultLanguage).get().then((_itemDescription) {
      if (_itemDescription.exists)
        return ItemTitle.toTitle(_itemDescription);
      else
        return ItemTitle(reference: reference.doc(currentLanguageCode));
    });
  }

  Future<ItemTitle> get currentDescriptionFuture async {
    var des = await future;
    if (des == null) des = await defaultFuture;

    return des;
  }

  Widget view() {
    return widget(
      (context, itemTitle) => Container(
        width: double.infinity,
        child: Text(
          itemTitle.text,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget widget(
    Widget Function(
      BuildContext context,
      ItemTitle title,
    )
        builder,
  ) {
    return StreamBuilder<ItemTitle>(
        stream: stream,
        builder: (context, _itemTitle) {
          if (Check.asyncSnapshot(_itemTitle)) {
            return builder(context, _itemTitle.data);
          } else
            return StreamBuilder<ItemTitle>(
                stream: defaultStream,
                builder: (context, _itemTitle) {
                  if (Check.asyncSnapshot(_itemTitle)) {
                    return builder(context, _itemTitle.data);
                  } else
                    return Center(child: Containers.waitting(context));
                });
        });
  }

  Widget editableStack() {
    return widget(
      (context, itemTitle) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: TextEditingController.fromValue(
              TextEditingValue(text: itemTitle.text)),
          readOnly: true,
          decoration: InputDecoration(
            labelText: S.of(context).account_name,
            suffixIcon: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return EditItemTitle(
                        itemTitle: itemTitle,
                        textEditingController: TextEditingController.fromValue(
                            TextEditingValue(text: itemTitle.text)),
                      );
                    });
              },
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 4,
                color: Theme.of(context).appBarTheme.color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// get all descriptions
  ///
  Widget allWidgets(
      Function(BuildContext context, ItemTitle title, Language language)
          builder) {
    return GetLanguages.build().widget((context, languages) {
      return ListView.builder(
        itemCount: languages.languages.length,
        itemBuilder: (context, index) {
          var language = languages.languages[index];
          return GetItemTitle(reference: reference.doc(language.languageId))
              .widget((context, description) =>
                  builder(context, description, language));
        },
      );
    });
  }

  /// show bottom model
  ///

  showEdittingScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(S.of(context).titles),
          ),
          body: allWidgets((context, title, language) =>
              title.widgets.withLanguageIcon(context, language)),
        ),
      );
    }));
  }
}
