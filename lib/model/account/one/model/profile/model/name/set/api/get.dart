import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/widget/containers.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/api/get.dart';
import 'package:hafeez/model/account/one/model/profile/model/name/one/model/name.dart';
import 'package:hafeez/model/language/set/api/get.dart';
import 'package:hafeez/model/language/one/model/data.dart';

class GetNames {
  final CollectionReference reference;
  final currentLanguageCode = S.current.languageCode;
  final String defaultLanguageCode;
  GetNames({@required this.reference, this.defaultLanguageCode = "ar"});

  Widget all(Function(BuildContext context, Language language, NameProfile name) builder) {
    return GetLanguages.build().widget((context, languages) {
      return ListView.builder(
          itemCount: languages.languages.length,
          itemBuilder: (context, index) {
            var language = languages.languages[index];
            return GetName(reference: reference.doc(language.languageId))
                .widget((context, name) => builder(context, language, name));
          });
    });
  }

  Stream<NameProfile> get stream => reference.doc(currentLanguageCode).snapshots().map((_name) {
        if (_name.exists)
          return NameProfile.toName(_name);
        else
          return null;
      });

  Stream<NameProfile> get defaultStream => reference.doc(defaultLanguageCode).snapshots().map((_name) {
        if (_name.exists)
          return NameProfile.toName(_name);
        else
          return NameProfile(reference: reference.doc(currentLanguageCode));
      });

  Widget currentName(Function(BuildContext context, NameProfile name) builder) {
    return StreamBuilder<NameProfile>(
        stream: stream,
        builder: (context, _name) {
          if (Check.asyncSnapshot(_name)) {
            return builder(context, _name.data);
          } else
            return StreamBuilder(
                initialData: NameProfile(
                  reference: reference.doc(defaultLanguageCode),
                ),
                stream: defaultStream,
                builder: (ctx, _name2) {
                  if (Check.asyncSnapshot(_name2))
                    return builder(ctx, _name2.data);
                  else
                    return Containers.waitting(context);
                });
        });
  }

  Future<NameProfile> get futureCurrentName async {
    var name = await reference.doc(currentLanguageCode).get().then((_name) {
      if (_name.exists)
        return NameProfile.toName(_name);
      else
        return null;
    });

    if (name == null)
      name = await reference.doc(defaultLanguageCode).get().then((_name) {
        if (_name.exists)
          return NameProfile.toName(_name);
        else
          return NameProfile(reference: reference.doc(currentLanguageCode));
      });

    return name;
  }

  Future<NameProfile> get futureName async {
    var name = await reference.doc(currentLanguageCode).get().then((_name) {
      if (_name.exists)
        return NameProfile.toName(_name);
      else
        return null;
    });

    if (name == null)
      name = await reference.doc(defaultLanguageCode).get().then((_name) {
        if (_name.exists)
          return NameProfile.toName(_name);
        else
          return NameProfile(reference: reference.doc(currentLanguageCode));
      });

    return name;
  }
}
