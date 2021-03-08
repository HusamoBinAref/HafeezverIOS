import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:hafeez/classes/database/firebase_selectors.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/authentication/model/authentication.dart';

class GetAuthentication {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user

  Authentication _userFromFirebaseUser(User user) {
    if (user != null) {
      return Authentication.toAuthentication(user);
    } else {
      return null;
    }
  }

  // auth change  user stream
  Stream<Authentication> get user =>
      _auth.authStateChanges().map(_userFromFirebaseUser);

  StreamBuilder<Authentication> streamBuilder(
      Widget Function(BuildContext context, Authentication auth) builder) {
    return StreamBuilder<Authentication>(
      stream: GetAuthentication().user,
      builder: (context, snap) {
        return builder(context, snap.data);
      },
    );
  }

  // sign in anon
  Future signInAnon() async {
    try {
      // ignore: missing_return
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign in with email and password
  Future<Authentication> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future<Authentication> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // update Account Info
  /// update display name
  Future updateDisplayName(String displayName) {
    var user = _auth.currentUser;
    return user.updateProfile(displayName: displayName);
  }

  /// update photo url
  Future updatePhotoUrl(String photoUrl) {
    var user = _auth.currentUser;
    return user.updateProfile(photoURL: photoUrl);
  }

  // static parts

  FirebaseAuth _staticAuth = FirebaseAuth.instance;

  Authentication _staticUserFromFirebaseUser(User user) {
    if (user != null) {
      return Authentication.toAuthentication(user);
    } else {
      return null;
    }
  }

  /// current User data
  Authentication get currentUser =>
      _staticUserFromFirebaseUser(_staticAuth.currentUser);

  DocumentReference get currentUserReference {
    var account = _staticUserFromFirebaseUser(_staticAuth.currentUser);
    if (account != null) return account.accountReference;
    return null;
  }

  Widget accountUser(Function(BuildContext context, Account account) builder) {
    return streamBuilder((context, auth) {
      if (auth != null)
        return currentUser.account
            .widget((context, account) => builder(context, account));
      else
        return Container();
    });
  }

  showIfEddingIsAllow({@required Widget child}) {
    return accountUser((context, account) {
      if (account.isSheikh)
        return child;
      else
        return Container();
    });
  }

  showIfEdittingIsAllow(
      {@required Widget child, @required DocumentReference reference}) {
    return accountUser((context, account) {
      if ((account.isSheikh && account.reference == reference))
        return child;
      else
        return Container();
    });
  }

  showIfOwnerOrManger(
      {@required Widget child, @required DocumentReference reference}) {
    return accountUser((context, account) {
      if ((account.reference == reference || account.isManager))
        return child;
      else
        return Container();
    });
  }

  showAccountStatus(
      BuildContext context,
      Widget Function(
              BuildContext context, bool isManager, bool isSheikh, bool isOwner)
          builder,
      {DocumentReference reference}) {
    if (isAuth)
      return accountUser((context, account) {
        return builder(context, account.isManager, account.isSheikh,
            reference == null ? false : account.reference == reference);
      });
    else
      return builder(context, false, false, false);
  }

  /// is this app authenticated
  bool get isAuth => (_staticAuth.currentUser != null);

  /// is this user owned a given item
  bool isOwner(DocumentReference ownerReference) =>
      _staticAuth.currentUser != null
          ? FirestoreSelectors.user.doc(_staticAuth.currentUser.uid) ==
              ownerReference
          : false;

  Stream<bool> get isManager => FirestoreSelectors.user
          .doc(_staticAuth.currentUser.uid)
          .snapshots()
          .map((user) {
        if (user.exists)
          return user.data()['isManager'] ?? false;
        else
          return false;
      });
}
