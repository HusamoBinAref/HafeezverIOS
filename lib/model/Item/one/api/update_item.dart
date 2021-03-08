import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/foundation.dart';

import 'package:hafeez/model/Item/one/model/description/one/model/description.dart';
import 'package:hafeez/model/Item/one/model/image/one/model/image.dart';
import 'package:hafeez/model/Item/one/model/title/one/model/data.dart';

class UpdateItem with ChangeNotifier {
  List<ItemTitle> titles = <ItemTitle>[];
  List<ItemImage> images = <ItemImage>[];
  List<ItemDescription> descriptions = <ItemDescription>[];

  /// take the references those are in firebase ...
  List<DocumentReference> currentReferences = <DocumentReference>[];

  /// take the references those were in firebase and add or remove to it before saving
  List<DocumentReference> updatedReferences = <DocumentReference>[];
}
