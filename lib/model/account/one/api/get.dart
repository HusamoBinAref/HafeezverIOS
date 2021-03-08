import 'package:cloud_firestore/cloud_firestore.dart' show DocumentReference;
import 'package:flutter/widgets.dart' show Widget, BuildContext, StreamBuilder;

import '../../../../classes/tools/check.dart';
import '../model/data.dart';

class GetAccount {
  final DocumentReference reference;

  GetAccount({
    this.reference,
  });

  /// this account stream
  Future<Account> get future => reference.get().then((_account) {
        if (_account.exists)
          return Account.build(_account);
        else
          return null;
      });
  Stream<Account> get stream => reference.snapshots().map((_account) {
        if (_account.exists)
          return Account.build(_account);
        else
          return Account.empty(
            _account.reference,
          );
      });

  /// this account solution Widget
  Widget widget(Function(BuildContext context, Account account) builder) {
    return StreamBuilder<Account>(
      initialData: Account.empty(reference),
      stream: stream,
      builder: (context, _account) {
        if (Check.asyncSnapshot(_account)) {
          return builder(context, _account.data);
        } else
          return builder(
            context,
            Account.empty(reference),
          );
      },
    );
  }

  /// Get all info about account
  Future getAllInfo() async {
    var account = await future;
    if (account != null) {
      // ignore: unused_local_variable
      var imageAccount = await account.profile.image.future;
      // ignore: unused_local_variable
      var nameAccount = await account.profile.names.futureName;
    }
    return null;
  }
}
