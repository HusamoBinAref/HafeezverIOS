import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/model/account/one/model/profile/image/one/api/modify.dart';

import 'package:hafeez/model/account/one/model/profile/model/image/widget/root.dart';

class ImageProfile {
  static ImageProfile toImageProfile(DocumentSnapshot document) {
    return ImageProfile(
      map: document.data(),
      reference: document.reference,
    );
  }

  ImageProfile({
    this.map,
    this.reference,
  });

  /// data
  final Map<String, dynamic> map;
  Map<String, dynamic> get _map => map ?? {};

  /// reference
  final DocumentReference reference;

  /// image
  String get url => _map['url'] ?? '';
 
  ImageProfileWidgets get widgets => ImageProfileWidgets(data: this);
  ModifyAccountImage get modify => ModifyAccountImage(data: this);
}
