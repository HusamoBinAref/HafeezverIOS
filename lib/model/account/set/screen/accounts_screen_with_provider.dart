import 'package:flutter/material.dart'show BuildContext, Key, StatelessWidget, Widget;
import 'package:provider/provider.dart'show ChangeNotifierProvider;

import '../api/get.dart';
import 'screen.dart';
import '../../../manament_status/ms_sheikh.dart';

class AccountsScreenWithProvider extends StatelessWidget {
  const AccountsScreenWithProvider({
    Key key,
    this.isSheikh = false,
  }) : super(key: key);
  final bool isSheikh;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MSSheikh>(
      create: (context) => MSSheikh(),
      child: AccountsScreen(
        accounts: isSheikh ? GetAccounts.build().isSheikh : GetAccounts.build(),
      ),
    );
  }
}
