import 'package:flutter/material.dart';

import '../../../../widget/containers.dart';

class WaittingUpload {
  static Widget spinKitCircle(BuildContext context) => Scaffold(
        body: Center(child: Containers.waitting(context)),
      );
}
