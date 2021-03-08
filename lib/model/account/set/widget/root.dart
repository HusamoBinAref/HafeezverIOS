import 'package:flutter/material.dart';
import 'package:hafeez/model/account/set/model/data.dart';
import 'package:hafeez/model/account/set/widget/gridView.dart';
import 'package:hafeez/model/account/set/widget/listView.dart';


class AccountsWidgets {
  final Accounts data;

  AccountsWidgets({@required this.data});

  Widget grid(BuildContext context) {
    return AccountGridView(data: data);
  } 

  Widget list(BuildContext context) {
    return AccountListView(data: data);
  }
}
