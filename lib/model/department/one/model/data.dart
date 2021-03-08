import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/model/department/one/model/title/set/api/get.dart';
import 'package:hafeez/model/department/one/widget/root.dart';

class Department {
  static Department toDepartment(DocumentSnapshot documentSnapshot) {
    return Department(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;
  bool isSelected = false;

  Department({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {};

  /// the default language
  String get defaultLanguageCode => _map['defaultLanguageCode'] ?? 'ar';

  GetDepartmentTitle get title => GetDepartmentTitle.build(reference,
      defaultLanguageCode: defaultLanguageCode);

  DepartmentWidgets get widgets => DepartmentWidgets(data: this);
}
