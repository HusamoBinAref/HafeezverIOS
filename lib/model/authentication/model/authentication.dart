import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' show FirebaseUser, UserUpdateInfo;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/account/one/api/get.dart';
import 'package:hafeez/model/account/one/model/followedS/api/followed.dart';
import 'package:hafeez/model/account/one/model/freinds/api/freinds.dart';


class Authentication {
  static Authentication toAuthentication(User user) {
    return Authentication(
      user: user,
    );
  }

  Authentication({
    this.user,
  });

  /// fire base user
  final User user;

  /// user ID
  String get uid => user.uid;

  /// provider ID
  // String get providerID => user.;

  /// photo url
  String get photoUrl => user.photoURL;

  /// email
  String get email => user.email;

  /// name
  String get userName => user.displayName;

  /// Account Reference
  DocumentReference get accountReference => FirestoreSelectors.user.doc(uid);

  /// Account
  GetAccount get account => GetAccount(
        reference: accountReference,
      );

  /// items
  CollectionReference get itemsReference => accountReference.collection("Item");

  /// Relationships/friends/Friends
  GetFreinds get friends => GetFreinds(
      reference: accountReference.collection('Relationships').doc('friends').collection('Friends'));

  /// Relationships/followeds/Followeds
  GetFolloweds get followeds => GetFolloweds(
      reference:
          accountReference.collection('Relationships').doc('followeds').collection('Followeds'));


  // update Account Info

  /// update display name
  Future updateDisplayName(String displayName) async {
    await user.updateProfile(
      displayName: displayName,
    );
  }

  /// update photo url
  Future updatePhotoUrl(String photoUrl) async {
    await user.updateProfile(photoURL: photoUrl);
  }
}
