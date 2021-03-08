import 'package:flutter/material.dart'
    show BuildContext, Key, StatelessWidget, Widget, required;
import 'package:provider/provider.dart' show ChangeNotifierProvider;

import '../../../manament_status/ms_all.dart';
import '../api/get.dart';
import '../widget/screen.dart';

class ItemScreenWithProvider extends StatelessWidget {
  const ItemScreenWithProvider({
    Key key,
    @required this.type,
  }) : super(key: key);
  final String type;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ManagementState>(
      create: (context) => ManagementState(),
      child: ItemsScreen(
        type: type,
        items: GetItems.build().byTypes(type),
      ),
    );
  }
}
