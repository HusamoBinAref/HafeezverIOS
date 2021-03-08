import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFolloweds {
  static GetFolloweds build() {
    return GetFolloweds(
        reference: FirebaseFirestore.instance.collectionGroup('Followeds'));
  }

  final Query reference; 

  GetFolloweds({this.reference});

//selections
  GetFolloweds byFreinds(List<DocumentReference> references) {
    return GetFolloweds(
        reference: reference.where(
      'followerReference',
      whereIn: references,
    ));
  }

  //
  Stream<List<DocumentReference>> stream() {
    return reference.snapshots().map((followeds) {
      if (followeds.docs.isNotEmpty) {
        return followeds.docs.map((followed) {
          return followed.data()['followedReference'] != null
              ? (followed.data()['followedReference'] as DocumentReference)
              : null;
        }).toList();
      } else
        return <DocumentReference>[];
    });
  }

  Widget widget(
      Function(BuildContext contextReferences,
              List<DocumentReference> references)
          builder,
      {Widget child}) {
    return StreamBuilder<List<DocumentReference>>(
      initialData: <DocumentReference>[],
      stream: stream(),
      builder: (context, snapshotReferences) {
        if (snapshotReferences.hasData && snapshotReferences.data.isNotEmpty) {
          return builder(context, snapshotReferences.data);
        }
        return child != null ? child : Container();
      },
    );
  }
}
