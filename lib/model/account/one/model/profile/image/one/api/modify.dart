import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';

class ModifyAccountImage {
  final ImageProfile data;

  ModifyAccountImage({@required this.data});

  Future setData(BuildContext context, String url) async {
    return await data.reference.set({"url": url});
  }
}
