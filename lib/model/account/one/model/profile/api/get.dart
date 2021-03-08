import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/foundation.dart' show required;
import 'package:hafeez/model/account/one/model/connection/api/email.dart';

import '../model/description/set/api/get.dart';
import '../model/image/api/get.dart';
import '../model/name/set/api/get.dart';
import '../widgets/root.dart';

class GetProfile {
  static GetProfile buildByAccount(DocumentReference accountReference) {
    return GetProfile(reference: accountReference);
  }

  final DocumentReference reference;

  GetProfile({@required this.reference});

  /// Account's name
  GetNames get names => GetNames(reference: reference.collection('Name'));

  /// Account's image
  GetImage get image =>
      GetImage(reference: reference.collection('Profile').doc('image'));

  /// Account's description
  GetDescriptions get descriptions =>
      GetDescriptions(reference: reference.collection('Description'));

  /// Account's Gmail
  GetEmail get email =>
      GetEmail(reference: reference.collection('Profile').doc('email'));

  AccountProfileWidgets get widgets => AccountProfileWidgets(profile: this);
}
