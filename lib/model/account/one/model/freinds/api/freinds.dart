import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/model/account/one/model/followedS/api/followed.dart';
import 'package:hafeez/model/account/one/model/freinds/model/freind.dart';

class GetFreinds {
  final Query reference;

  GetFreinds({this.reference});

  Stream<List<Friend>> get stream {
    return reference.snapshots().map((snapshotFriends) {
      if (snapshotFriends.docs.isNotEmpty)
        return snapshotFriends.docs.map(Friend.toFriend).toList();
      else
        return <Friend>[];
    });
  }

  Widget widget(
      Function(BuildContext contextFriends, List<Friend> friends) builder,
      {Widget child}) {
    return StreamBuilder<List<Friend>>(
      initialData: <Friend>[],
      stream: stream,
      builder: (context, snapshotFriends) {
        if (snapshotFriends.hasData && snapshotFriends.data.isNotEmpty)
          return builder(context, snapshotFriends.data);
        return child != null ? child : Container();
      },
    );
  }

  Widget friendsFollowed(
      Function(BuildContext contextFolloweds, GetFolloweds followeds) builder) {
    return widget((contextFriends, freinds) {
      return builder(
        contextFriends,
        GetFolloweds.build().byFreinds(
          freinds.map((freind) => freind.friendReference).toList(),
        ),
      );
    },
        child: Container(
          child: Text('no things....'),
        ));
  }

  // future
}
