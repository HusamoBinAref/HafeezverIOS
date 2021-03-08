import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/generated/l10n.dart';
import '../model/title.dart';

class GetSpecializationTitle {
  static GetSpecializationTitle build(DocumentReference reference, {String defaultLanguageCode}) {
    return GetSpecializationTitle(reference: reference.collection('Title'), defaultLanguageCode: defaultLanguageCode);
  }

  final CollectionReference reference;
  final String defaultLanguageCode;

  GetSpecializationTitle({
    this.defaultLanguageCode = 'ar',
    this.reference,
  });

  Stream<SpecializationTitle> get stream {
    return reference.doc(S.current.languageCode).snapshots().map((title) {
      return title.exists ? SpecializationTitle.toTitle(title) : null;
    });
  }

  Stream<SpecializationTitle> get streamDefault {
    return reference.doc(defaultLanguageCode).snapshots().map((title) {
      return title.exists
          ? SpecializationTitle.toTitle(title)
          : SpecializationTitle.initialClass(S.current.languageCode, reference);
    });
  }

  Widget widget(
      {@required Function(BuildContext context, SpecializationTitle title) builder, bool isPrimary = false, Widget child}) {
    return StreamBuilder<SpecializationTitle>(
        initialData: SpecializationTitle.initialClass(S.current.languageCode, reference),
        stream: stream,
        builder: (context, _title) {
          if (Check.asyncSnapshot(_title))
            return builder(context, _title.data);
          else
            return StreamBuilder<SpecializationTitle>(
                initialData: SpecializationTitle.initialClass(defaultLanguageCode, reference),
                stream: streamDefault,
                builder: (context, _titleDefault) {
                  if (Check.asyncSnapshot(_titleDefault))
                    return builder(context, _titleDefault.data);
                  else
                    return isPrimary
                        ? builder(context, SpecializationTitle.initialClass(S.current.languageCode, reference))
                        : child != null
                            ? child
                            : Container();
                });
        });
  }
}
