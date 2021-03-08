import 'package:flutter/material.dart';
import 'package:hafeez/classes/commends/key_words.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/Item/set/api/get.dart';
import 'package:hafeez/model/Item/set/widget/screen.dart';
import 'package:hafeez/model/department/one/model/data.dart';
import 'package:hafeez/model/department/one/model/title/one/model/title.dart';
import 'package:hafeez/widget/model/page_tabs.dart';
import 'package:hafeez/widget/page_tabs.dart';
import 'package:provider/provider.dart';

import '../../../manament_status/ms_all.dart';

class DepartmentScreen extends StatelessWidget {
  const DepartmentScreen({
    Key key,
    @required this.data,
    @required this.title,
  }) : super(key: key);

  final Department data;
  final DepartmentTitle title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    title != null
                        ? Hero(
                            tag: data.reference.path,
                            child: Card(
                              color: Colors.transparent,
                              margin: const EdgeInsets.all(0),
                              elevation: 0,
                              child: Text(
                                title.text,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          )
                        : data.title.widget(
                            builder: (context, title) {
                              return Hero(
                                tag: data.reference.path,
                                child: Card(
                                  color: Colors.transparent,
                                  margin: const EdgeInsets.all(0),
                                  elevation: 0,
                                  child: Text(
                                    title.text,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              )),
          body: PageTabs(pages: [
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
                create: (context) =>
                    ManagementState(departmentReference: data.reference),
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
                create: (context) =>
                    ManagementState(departmentReference: data.reference),
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
                create: (context) =>
                    ManagementState(departmentReference: data.reference),
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
                create: (context) =>
                    ManagementState(departmentReference: data.reference),
                child: ItemsScreen(
                  type: KeyWords.itemKeyWords[3],
                  items: GetItems.build().byTypes('Voice'),
                  isDepartment: true,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
