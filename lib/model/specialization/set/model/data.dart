import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/specialization/one/model/specialization.dart';
import 'package:hafeez/model/specialization/set/widget/root.dart';

class Specializations {
  static Specializations build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty) {
      return Specializations(
          specializations: snapshot.docs.map(Specialization.toSpecialization).toList());
    } else
      return Specializations(specializations: []);
  }

  final List<Specialization> specializations;

  Specializations({@required this.specializations});

  SpecailizationsWidgets get widgets => SpecailizationsWidgets(data: this);
}
