import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/profile/model/description/one/model/data.dart';
import 'package:hafeez/widget/containers.dart';

class GetDescription {
  final DocumentReference reference;
  GetDescription({
    this.reference,
  });

  Stream<DescriptionProfile> get stream => reference.snapshots().map((_descriptoin) {
        if (_descriptoin.exists)
          return DescriptionProfile.toDescriptoin(_descriptoin);
        else
          return DescriptionProfile(reference: reference);
      });

  Widget widget(
    Function(BuildContext context, DescriptionProfile description) builder, {
    Widget child,
    bool isPrimary = false,
  }) {
    return StreamBuilder<DescriptionProfile>(
        stream: stream,
        builder: (context, _description) {
          if (Check.asyncSnapshot(_description)) {
            return builder(context, _description.data);
          } else
            
            return Center(child: Center(child: Containers.waitting(context)));
        });
  }
}
