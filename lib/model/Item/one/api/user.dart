import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/account/one/model/profile/api/get.dart';
import 'package:hafeez/model/account/one/model/profile/model/image/api/get.dart';

class GetUser {
  final DocumentReference reference;

  GetUser({
    @required this.reference,
  });

  /// user's name
  GetProfile get profile => GetProfile(reference: reference);

  /// user's image
  GetImage get image => GetImage(reference: reference.collection('Profile').doc('image'));
}
