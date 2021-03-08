import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'
    show StreamBuilder, BuildContext, Widget, Container, TextStyle;
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/description/one/api/get.dart';
import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/description/one/widget/Editting_Description.dart';
import 'package:hafeez/model/language/set/api/get.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class GetItemDescriptions {
  static GetItemDescriptions build(DocumentReference reference) {
    return GetItemDescriptions(reference: reference.collection('Description'));
  }

  final CollectionReference reference;
  final String defaultLanguage;
  final String currentLanguageCode = S.current.languageCode;
  GetItemDescriptions({
    this.reference,
    this.defaultLanguage,
  });

  Stream<ItemDescription> get stream {
    return reference
        .doc(currentLanguageCode)
        .snapshots()
        .map((_itemDescription) {
      if (_itemDescription.exists)
        return ItemDescription.toDescription(_itemDescription);
      else
        return null;
    });
  }

  Stream<ItemDescription> get defaultStream {
    return reference.doc(defaultLanguage).snapshots().map((_itemDescription) {
      if (_itemDescription.exists)
        return ItemDescription.toDescription(_itemDescription);
      else
        return ItemDescription(reference: reference.doc(currentLanguageCode));
    });
  }

  Widget widget(
      Function(BuildContext context, ItemDescription description) builder) {
    return StreamBuilder<ItemDescription>(
        stream: stream,
        builder: (context, _itemDescription) {
          if (Check.asyncSnapshot(_itemDescription)) {
            return builder(context, _itemDescription.data);
          } else
            return StreamBuilder<ItemDescription>(
                stream: defaultStream,
                builder: (context, _itemDescription) {
                  if (Check.asyncSnapshot(_itemDescription)) {
                    return builder(context, _itemDescription.data);
                  } else
                    return Center(child: Containers.waitting(context));
                });
        });
  }

  Widget view() {
    return widget(
      (context, itemDescription) =>
          Container(width: double.infinity, child: Text(itemDescription.text)),
    );
  }

  Widget editableStack() {
    return this.widget(
      (context, itemDescription) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: TextEditingController.fromValue(
              TextEditingValue(text: itemDescription.text)),
          readOnly: true,
          decoration: InputDecoration(
            labelText: S.of(context).item_description,
            suffixIcon: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showBottomSheet(
                    context: context,
                    builder: (ctx) {
                      return EditItemDescription(
                        itemDescription: itemDescription,
                        textEditingController: TextEditingController.fromValue(
                            TextEditingValue(text: itemDescription.text)),
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
      Function(BuildContext context, ItemDescription description,
              Language language)
          builder) {
    return GetLanguages.build().widget((context, languages) {
      return ListView.builder(
        itemCount: languages.languages.length,
        itemBuilder: (context, index) {
          var language = languages.languages[index];
          return GetItemDescription(
                  reference: reference.doc(language.languageId))
              .widget((context, description) =>
                  builder(context, description, language));
        },
      );
    });
  }

  showEdittingScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).descriptions),
              centerTitle: true,
            ),
            body: allWidgets(
              (context, description, language) =>
                  description.widgets.withLanguageIcon(context, language),
            ),
          ),
        );
      },
    ));
  }

// Future
  Future<ItemDescription> get future {
    return reference.doc(currentLanguageCode).get().then((_itemDescription) {
      if (_itemDescription.exists)
        return ItemDescription.toDescription(_itemDescription);
      else
        return null;
    });
  }

  Future<ItemDescription> get defaultFuture {
    return reference.doc(defaultLanguage).get().then((_itemDescription) {
      if (_itemDescription.exists)
        return ItemDescription.toDescription(_itemDescription);
      else
        return ItemDescription(reference: reference.doc(currentLanguageCode));
    });
  }

  Future<ItemDescription> get currentDescriptionFuture async {
    var des = await future;
    if (des == null) des = await defaultFuture;

    return des;
  }
}
