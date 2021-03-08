import 'package:flutter/material.dart' show BuildContext, Center, StreamBuilder, Widget;
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/controller/model/data.dart';
import 'package:hafeez/model/Item/set/controller/model/video.dart';
import 'package:hafeez/model/department/set/api/get.dart';
import 'package:hafeez/model/department/set/model/data.dart';
import 'package:hafeez/model/language/set/api/get.dart';
import 'package:hafeez/model/language/set/model/data.dart';
import 'package:hafeez/model/word/set/model/data.dart';
import 'package:hafeez/model/word/words.dart';
import 'package:hafeez/widget/containers.dart';

class GetItemModel {
  static Widget model(String type, Function(BuildContext context, ItemModel model) builder,
      {VideoModel videoModel,String bookUrl}) {
    return StreamBuilder<Languages>(
        stream: GetLanguages.build().stream,
        builder: (context, titlesShot) {
          return StreamBuilder<Languages>(
              stream: GetLanguages.build().stream,
              builder: (context, descriptionsShot) {
                return StreamBuilder<Departments>(
                    stream: GetDepartments.build.stream,
                    builder: (context, departmentsShot) {
                      return StreamBuilder<Words>(
                          stream: GetWords.build.stream,
                          builder: (context, wordsShot) {
                            if (Check.asyncSnapshot(titlesShot) &&
                                Check.asyncSnapshot(descriptionsShot) &&
                                Check.asyncSnapshot(departmentsShot) &&
                                Check.asyncSnapshot(wordsShot)) {
                              //is video
                              var titles = titlesShot.data;
                              if (KeyWords.itemKeyWords[2] == type)
                                titles.languages
                                    .firstWhere((element) =>
                                        element.languageCode.contains(S.current.languageCode))
                                    .textEditingController
                                    .text = videoModel.title;
                              return builder(
                                  context,
                                  ItemModel(
                                    titleList: titles,
                                    descriptionList: descriptionsShot.data,
                                    departmentsList: departmentsShot.data,
                                    wordsList: wordsShot.data,
                                    type: type,
                                    videoModel: videoModel,
                                  ));
                            } else
                              return Center(child: Containers.waitting(context));
                          });
                    });
              });
        });
  }
}
