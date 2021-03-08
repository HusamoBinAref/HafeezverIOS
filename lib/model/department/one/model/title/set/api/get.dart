import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/department/one/model/title/one/model/title.dart';

class GetDepartmentTitle {
  static GetDepartmentTitle build(DocumentReference reference,
      {String defaultLanguageCode}) {
    return GetDepartmentTitle(
        reference: reference.collection('Title'),
        defaultLanguageCode: defaultLanguageCode);
  }

  final CollectionReference reference;
  final String defaultLanguageCode;

  GetDepartmentTitle({
    this.defaultLanguageCode = 'ar',
    this.reference,
  });

  Stream<DepartmentTitle> get stream {
    return reference.doc(S.current.languageCode).snapshots().map((title) {
      return title.exists ? DepartmentTitle.toTitle(title) : null;
    });
  }

  Stream<DepartmentTitle> get streamDefault {
    return reference.doc(defaultLanguageCode).snapshots().map((title) {
      return title.exists
          ? DepartmentTitle.toTitle(title)
          : DepartmentTitle.initialClass(S.current.languageCode, reference);
    });
  }

  Widget widget(
      {@required Function(BuildContext context, DepartmentTitle title) builder,
      bool isPrimary = false,
      Widget child}) {
    return StreamBuilder<DepartmentTitle>(
        initialData:
            DepartmentTitle.initialClass(S.current.languageCode, reference),
        stream: stream,
        builder: (context, _title) {
          if (Check.asyncSnapshot(_title))
            return builder(context, _title.data);
          else
            return StreamBuilder<DepartmentTitle>(
                stream: streamDefault,
                builder: (context, _titleDefault) {
                  if (Check.asyncSnapshot(_titleDefault))
                    return builder(context, _titleDefault.data);
                  else
                    return child != null ? child : Container();
                });
        });
  }
}
