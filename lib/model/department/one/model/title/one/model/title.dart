import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/department/one/model/title/one/widget/root.dart';

class DepartmentTitle {
  static DepartmentTitle toTitle(DocumentSnapshot documentSnapshot) {
    return DepartmentTitle(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  static DepartmentTitle initialClass(String defaultLanguageCode, CollectionReference reference) {
    return DepartmentTitle(reference: reference.doc(S.current.languageCode));
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;
  DepartmentTitle({
    this.map,
    this.reference,
  });
  Map<String, dynamic> get _map => map ?? {};

  String get text => _map['text'] ?? '';

  DepartmentTitleWidgets get widgets => DepartmentTitleWidgets(data: this);
}
