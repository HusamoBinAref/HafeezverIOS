import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/manament_status/ms_all.dart';
import 'package:hafeez/model/manament_status/ms_sheikh.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import './title/one/api/title.dart';
import 'package:hafeez/model/specialization/set/api/get.dart';
import 'package:hafeez/model/Item/set/widget/screen.dart';
import 'package:hafeez/widget/model/page_tabs.dart';
import 'package:hafeez/widget/page_tabs.dart';
import 'package:provider/provider.dart';

class Specialization {
  static Specialization toSpecialization(DocumentSnapshot documentSnapshot) {
    return Specialization(
      reference: documentSnapshot.reference,
      map: documentSnapshot.data(),
    );
  }

  final DocumentReference reference;
  final Map<String, dynamic> map;

  Specialization({
    this.map,
    this.reference,
  });

  Map<String, dynamic> get _map => map ?? {};

  String get defaultLanguageCode => _map['defaultLanguageCode'] ?? 'ar';

  bool isSelected = false;

  GetSpecializationTitle get title => GetSpecializationTitle.build(reference, defaultLanguageCode: defaultLanguageCode);

// Tile
  Widget categoryTile(
    BuildContext context, {
    Color primaryColor = Colors.blue,
    Color secondryColor = Colors.white,
    double kDefaultPadding = 10,
  }) {
    return Consumer<MSSheikh>(
      builder: (context, MSSheikh managementState, _) => GestureDetector(
        onTap: () {
          managementState.addSpecialization(this.reference);
        },
        child: title.widget(
          builder: (context, _title) => Tooltip(
            message: _title.text,
            child: LimitedBox(
              maxWidth: 300,
              maxHeight: GetSpecializations.maxRowHeight,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                decoration: BoxDecoration(
                  color: managementState.isSpecializationSelected(this.reference) ? primaryColor : primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _title.text,
                      style: TextStyle(
                        color: managementState.isSpecializationSelected(this.reference) ? secondryColor : primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _screen(BuildContext context) {
    return PageTabs(pages: [
      PageData(
        tab: Tab(
          child: Row(
            children: [
              Icon(Icons.library_books),
              SizedBox(width: 5),
              Text(S.of(context).posts),
            ],
          ),
        ),
        child: ChangeNotifierProvider<ManagementState>(
          create: (context) => ManagementState(departmentReference: reference),
          child: ItemsScreen(
            type: KeyWords.itemKeyWords[1],
            items: GetItems.build().byTypes('Post'),
            isDepartment: true,
          ),
        ),
      ),
      PageData(
        tab: Tab(
          child: Row(
            children: [
              Icon(Icons.book),
              SizedBox(width: 5),
              Text(S.of(context).books),
            ],
          ),
        ),
        child: ChangeNotifierProvider<ManagementState>(
          create: (context) => ManagementState(departmentReference: reference),
          child: ItemsScreen(
            type: KeyWords.itemKeyWords[0],
            items: GetItems.build().byTypes('Book'),
            isDepartment: true,
          ),
        ),
      ),
      PageData(
        tab: Tab(
          child: Row(
            children: [
              Icon(Icons.videocam),
              SizedBox(width: 5),
              Text(S.of(context).videos),
            ],
          ),
        ),
        child: ChangeNotifierProvider<ManagementState>(
          create: (context) => ManagementState(departmentReference: reference),
          child: ItemsScreen(
            type: KeyWords.itemKeyWords[2],
            items: GetItems.build().byTypes('Video'),
            isDepartment: true,
          ),
        ),
      ),
      PageData(
        tab: Tab(
          child: Row(
            children: [
              Icon(Icons.keyboard_voice),
              SizedBox(width: 5),
              Text(S.of(context).voices),
            ],
          ),
        ),
        child: ChangeNotifierProvider<ManagementState>(
          create: (context) => ManagementState(departmentReference: reference),
          child: ItemsScreen(
            type: KeyWords.itemKeyWords[3],
            items: GetItems.build().byTypes('Voice'),
            isDepartment: true,
          ),
        ),
      ),
    ]);
  }

  void goToScreen(BuildContext context, {bool replacing = false}) {
    if (replacing)
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return _screen(context);
        },
      ));
    else
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return _screen(context);
        },
      ));
  }
}
