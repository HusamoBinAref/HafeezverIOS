import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hafeez/model/account/one/model/data.dart';
import 'package:hafeez/model/account/set/widget/root.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';

class Accounts {
  static Accounts build(QuerySnapshot snapshot) {
    if (snapshot.docs.isNotEmpty)
      return Accounts(accounts: snapshot.docs.map(Account.build).toList());
    else
      return Accounts(accounts: []);
  }

  final List<Account> accounts;
  List<Account> get accountsWithOutMe => GetAuthentication().isAuth
      ? accounts
          .where((element) =>
              element.reference.id != FirebaseAuth.instance.currentUser.uid)
          .toList()
      : accounts;

  Accounts({@required this.accounts});

  Accounts getByType({bool isSheikh = false}) {
    return Accounts(
        accounts:
            accounts.where((account) => account.isSheikh == isSheikh).toList());
  }

  AccountsWidgets get widgets => AccountsWidgets(data: this);
}
