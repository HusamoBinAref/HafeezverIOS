import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        EdgeInsets,
        Icon,
        IconButton,
        Icons,
        ListTile,
        Text,
        TextEditingController,
        TextStyle,
        Theme,
        Widget,
        TextOverflow;
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

class Language {
  static Language biuld(DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      var language = Language(
        snapshot: documentSnapshot,
        inputReference: documentSnapshot.reference,
      );

      if (language.languageCode == S.current.languageCode) language.isSelected = true;
      return language;
    } else
      return Language(inputReference: documentSnapshot.reference);
  }

  final DocumentReference inputReference;
  final DocumentSnapshot snapshot;

  Language({
    this.snapshot,
    this.inputReference,
  });
  bool get isNotNull => snapshot != null;
  Map<String, dynamic> get _map => isNotNull
      ? snapshot.data() ??
          {
            "name": "arabic",
            "icon": "",
            "code": "ar",
          }
      : {
          "name": "arabic",
          "icon": "",
          "code": "ar",
        };

  DocumentReference get reference => isNotNull ? snapshot.reference : inputReference;

  String get languageId => reference != null ? reference.id : 'ar';

  String get name => _map['name'] ?? '';

  /// get icon Url
  String get icon => _map['icon'] ?? '';

  /// get icon widget
  Widget iconWidget(BuildContext context) => CacheImageWidget(
        imageUrl: icon,
        assetImageTag: PlaceHolderImages.languageIcon,
      );

  /// get language code
  String get languageCode => _map['code'] ?? 'ar';

  ///

  bool _isSelected = false;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
    return null;
  }

  toggleSelection() {
    isSelected = !isSelected;
  }

  final TextEditingController textEditingController = TextEditingController();

  Widget card(BuildContext context, Function(Language language) toggleLanguage) {
    return Card(
      child: ListTile(
        selected: isSelected,
        selectedTileColor: Theme.of(context).primaryColorLight,
        contentPadding: const EdgeInsets.all(5),
        leading: iconWidget(context),
        title: Text(name,
            style: TextStyle(
              color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).primaryColorLight,
            )),
        trailing: IconButton(
          icon: isSelected
              ? Icon(
                  Icons.delete,
                  color: Theme.of(context).primaryColor,
                )
              : Icon(
                  Icons.add_circle_outline,
                  color: Theme.of(context).primaryColorLight,
                ),
          onPressed: () {
            toggleLanguage(this);
          },
        ),
      ),
    );
  }

  Widget tile(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.all(5),
        leading: iconWidget(context),
        title: Text(name,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            )),
        subtitle: Text(textEditingController.value.text,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            )),
      ),
    );
  }
}
