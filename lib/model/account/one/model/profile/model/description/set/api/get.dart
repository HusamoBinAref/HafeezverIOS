import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/api/get.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/model/language/set/api/get.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

import '../../../../../../../../../generated/l10n.dart';

class GetDescriptions {
  static GetDescriptions build(DocumentReference reference) {
    return GetDescriptions(reference: reference.collection("Description"));
  }

  final CollectionReference reference;
  final currentLanguageCode = S.current.languageCode;
  GetDescriptions({
    this.reference,
  });

  Widget all(
      Function(BuildContext context, Language language,
              DescriptionProfile description)
          builder) {
    return GetLanguages.build().widget((context, languages) {
      return ListView.builder(
          itemCount: languages.languages.length,
          itemBuilder: (context, index) {
            var language = languages.languages[index];
            return GetDescription(reference: reference.doc(language.languageId))
                .widget((context, description) =>
                    builder(context, language, description));
          });
    });
  }

  Stream<DescriptionProfile> get stream =>
      reference.doc(currentLanguageCode).snapshots().map((_descriptoin) {
        if (_descriptoin.exists)
          return DescriptionProfile.toDescriptoin(_descriptoin);
        else
          return null;
      });

  Future<DescriptionProfile> get future =>
      reference.doc(currentLanguageCode).get().then((_descriptoin) {
        if (_descriptoin.exists)
          return DescriptionProfile.toDescriptoin(_descriptoin);
        else
          return null;
      });
  Future<DescriptionProfile> get defaultFuture =>
      reference.doc('ar').get().then((_descriptoin) {
        if (_descriptoin.exists)
          return DescriptionProfile.toDescriptoin(_descriptoin);
        else
          return DescriptionProfile(
            reference: reference.doc(currentLanguageCode),
          );
      });

  Future<DescriptionProfile> get currentDescriptionFuture async {
    var des = await future;
    if (des == null) des = await defaultFuture;

    return des;
  }

  Stream<DescriptionProfile> get defaultStream =>
      reference.doc('ar').snapshots().map((_descriptoin) {
        if (_descriptoin.exists)
          return DescriptionProfile.toDescriptoin(_descriptoin);
        else
          return DescriptionProfile(
            reference: reference.doc(currentLanguageCode),
          );
      });

  Widget currentDescription(
    Function(BuildContext context, DescriptionProfile description) builder,
  ) {
    return StreamBuilder<DescriptionProfile>(
        stream: stream,
        builder: (context, _descriptoin) {
          if (Check.asyncSnapshot(_descriptoin)) {
            return builder(context, _descriptoin.data);
          } else
            return StreamBuilder<DescriptionProfile>(
                stream: defaultStream,
                builder: (ctx, _descriptoin) {
                  if (Check.asyncSnapshot(_descriptoin))
                    return builder(ctx, _descriptoin.data);
                  else
                    return Center(child: Containers.waitting(context));
                });
        });
  }
}
