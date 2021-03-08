import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/material.dart'show BuildContext, Center, StreamBuilder, Widget;

import '../../../../../../../../classes/tools/check.dart';
import '../../../../../../../../widget/containers.dart';
import '../model/image.dart';

class GetImage {
  final DocumentReference reference;

  GetImage({
    this.reference,
  });

  Stream<ImageProfile> get stream => reference.snapshots().map((_imageProfile) {
        if (_imageProfile.exists)
          return ImageProfile.toImageProfile(_imageProfile);
        else
          return ImageProfile(
            reference: reference,
          );
      });

  Widget widget(Function(BuildContext context, ImageProfile image) builder) {
    return StreamBuilder<ImageProfile>(
        
        stream: stream,
        builder: (context, _imageProfile) {
          if (Check.asyncSnapshot(_imageProfile)) {
            return builder(context, _imageProfile.data);
          } else
            return Center(child: Containers.waitting(context));
        });
  }

  Future<ImageProfile> get future => reference.get().then((_imageProfile) {
        if (_imageProfile.exists)
          return ImageProfile.toImageProfile(_imageProfile);
        else
          return ImageProfile(
            reference: reference,
          );
      });
}
