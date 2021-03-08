import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentReference, DocumentSnapshot, Timestamp;
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/one/model/audio/api/get.dart';
import 'package:hafeez/model/Item/one/model/book/set/api/get.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/Item/one/model/description/set/api/get.dart';
import 'package:hafeez/model/Item/one/model/image/one/api/get.dart';
import 'package:hafeez/model/Item/one/model/references.dart';
import 'package:hafeez/model/Item/one/model/title/set/api/get.dart';

import 'package:hafeez/model/Item/one/widget/root.dart';

import 'package:hafeez/model/account/one/api/get.dart';
import 'package:hafeez/model/account/one/model/favorite/one/api/get.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';

import 'package:intl/intl.dart';

import 'video/api/get.dart';

class ITem {
  static ITem toItem(DocumentSnapshot documentSnapshot) {
    return ITem(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
      documentSnapshot: documentSnapshot,
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;
  final DocumentSnapshot documentSnapshot;

  ITem({this.map, this.reference, this.documentSnapshot});

  Map<String, dynamic> get _map => map ?? {};

  /// * get type of item
  String get type => _map['type'] ?? '';

  /// * get default language of item
  String get defaultLanguage => _map['defaultLanguage'] ?? 'ar';

  /// * get departments of item
  ItemReferences get references => ItemReferences(
      references: List<DocumentReference>.from(_map['references'] ?? []),
      iTem: this);

  set upDateReferences(List<DocumentReference> referencesList) =>
      map['references'] = referencesList;

  /// Item create date 
  ///
  DateTime get createAt => (_map['createAt'] as Timestamp).toDate();

  String get createString {
    if (createAt != null) {
      var format = DateFormat.yMMMd(S.current.languageCode);
      return format.format(createAt);
    }
    return '';
  }

  ///
  GetFavorite get favoriteStatus => GetAuthentication().isAuth
      ? GetFavorite.buildForItem(reference: reference, type: type)
      : GetFavorite(reference: reference, type: type);

  /// * get title of item
  /// this will get title of item by current language of app if there is title in current language
  /// if not fount this will get title of item by default language of this item.
  GetItemTitles get titles => GetItemTitles(
      reference: reference.collection('Title'),
      defaultLanguage: defaultLanguage);

  /// * get image of item
  /// this will get image of item by current language of app if there is image in current language
  /// if not fount this will get image of item by default language of this item.
  GetItemImage get image =>
      GetItemImage(reference: reference.collection('Image').doc('image'));

  /// * get file of item
  /// this will get file of item by current language of app if there is file in current language
  /// if not fount this will get file of item by default language of this item.
  GetItemBooks get books => GetItemBooks(
        query: FirestoreSelectors.itemBooks(reference)
            .where("url", isNotEqualTo: "", isGreaterThan: ""),
      );

  /// * get file of item
  /// this will get file of item by current language of app if there is file in current language
  /// if not fount this will get file of item by default language of this item.
  GetItemVideo get video => GetItemVideo(
      reference: reference.collection(KeyWords.itemKeyWords[2]),
      defaultLanguage: defaultLanguage);

  /// * get file of item
  /// this will get file of item by current language of app if there is file in current language
  /// if not fount this will get file of item by default language of this item.
  GetItemAudio get audio => GetItemAudio.buildByItem(reference, 'ar');

  /// * get description of item
  /// this will get description of item by current language of app if there is description in current language
  /// if not fount this will get description of item by default language of this item.
  GetItemDescriptions get descriptions => GetItemDescriptions(
      reference: reference.collection('Description'),
      defaultLanguage: defaultLanguage);

  /// Account data
  GetAccount get user => GetAccount(reference: (reference.parent.parent));

  /// items those relative to this item

  GetItems get relativesItems => GetItems.build()
      .byDate(descending: true)
      .byTypes(type)
      .byAnyReferences([
        ...references.departmentsReferences.take(5).toList(),
        ...references.wordsReferences.take(5).toList()
      ])
      .byLimits(5)
      .currentItem(this.reference);

  ItemWidgets get widgets => ItemWidgets(iTem: this);
}
