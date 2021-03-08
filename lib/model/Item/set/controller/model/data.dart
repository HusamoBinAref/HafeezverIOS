import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/controller/model/Voice.dart';
import 'package:hafeez/model/Item/set/controller/model/video.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/department/set/model/data.dart';
import 'package:hafeez/model/language/set/model/data.dart';
import 'package:hafeez/model/word/Model/word.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/model/word/set/model/data.dart';

class ItemModel {
  final String type;
  final Languages titleList;
  final Languages descriptionList;
  final Departments departmentsList;
  final Words wordsList;

  final VideoModel videoModel;
  final VoiceModel voiceModel;
   String bookUrl;
  ItemModel({
    @required this.type,
    @required this.titleList,
    @required this.descriptionList,
    @required this.departmentsList,
    @required this.wordsList,
    this.videoModel,
    this.voiceModel,
    this.bookUrl,
  });

  bool isLoading = false;
  Function close = () {};
  // keys
  GlobalKey<ScaffoldState> scaffoldKey;
  int pageCount = 6;
  static const int page_Count = 6;
  var formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // pages
  // TabController pages = TabController(length: page_Count, initialIndex: 0, vsync: TickerProvider );

  bool isPageTrue(int index) {
    return pageNo >= index;
  }

  int pageNo = 0;

  List<Map<String, dynamic>> get pages => [
        {
          'status': isPageTrue(0),
          'widget': Text('1'),
        },
        {
          'status': isPageTrue(1),
          'widget': Text('2'),
        },
        {
          'status': isPageTrue(2),
          'widget': Text('3'),
        },
        {
          'status': isPageTrue(3),
          'widget': Text('4'),
        },
        {
          'status': isPageTrue(4),
          'widget': Text('5'),
        },
      ];

// titles

  List<Language> get selectedTitles => titleList.selected;

// Descriptions
  List<Language> get selectedDescriptions => descriptionList.selected;

// image

// departments
  List<Department> get selectedDepartments => departmentsList.selected;

  /// search department controller
  TextEditingController searchDepartmentController = TextEditingController();

// words
  List<Word> get selectedWords => wordsList.selected;

  /// search word controller
  TextEditingController searchWordController = TextEditingController();

  bool get checkImagePage {
    if (pageNo == 5) return true;
    return false;
  }

  void move(int value) {
    if (pageNo != value &&
        (value < pageNo || formKeys[pageNo].currentState.validate())) {
      pageNo = value;
    }
  }

  void next() {
    if (formKeys[pageNo].currentState.validate()) {
      pageNo++;
    }
  }

  void previous() {
    pageNo--;
  }

  List<DocumentReference> get references => [
        ...selectedDepartments.map((element) => element.reference).toList(),
        ...selectedWords.map((element) => element.reference).toList(),
        GetAuthentication().currentUser.accountReference,
      ];

  Future<String> create(BuildContext context) async {
    if (selectedTitles.isNotEmpty) {
      return await GetAuthentication().currentUser.itemsReference.add(
        {
          "createAt": Timestamp.now(),
          "type": type,
          "references": references,
          "defaultLanguageCode": S.of(context).languageCode,
        },
      ).then((itemReference) async {
        if (itemReference != null) {
          if (type == KeyWords.itemKeyWords[2]) {
            var videoResult = await videoModel.add(itemReference);
            if (videoResult == null && videoResult == "error") {
              itemReference.delete();
              return "error in video";
            }
          } else if (type == KeyWords.itemKeyWords[0]) {
            itemReference.collection("Book").doc(S.of(context).languageCode).set({"url":bookUrl});
          }

          //
          for (var item in selectedTitles) {
            await itemReference.collection("Title").doc(item.languageCode).set({
              "text": item.textEditingController.value.text,
            }, SetOptions(merge: true));
          }

          //
          for (var item in selectedDescriptions) {
            await itemReference
                .collection("Description")
                .doc(item.languageCode)
                .set({
              "text": item.textEditingController.value.text,
            }, SetOptions(merge: true));
          }
          return "done";
        } else {
          return "error";
        }
      });
    } else
      return "No title";
  }
}
