import 'package:flutter/material.dart';
import 'package:hafeez/widget/model/page_tabs.dart';

class PageTabs extends StatelessWidget {
  const PageTabs({
    Key key,
    @required this.pages,
  }) : super(key: key);
  final List<PageData> pages;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            primary: true,
            automaticallyImplyLeading: false,
            title: TabBar(
              isScrollable: true,
              indicatorColor: Theme.of(context).tabBarTheme.labelColor,
              // page tabs
              tabs: pages.map((e) => e.tab).toList(),
              unselectedLabelStyle: Theme.of(context).textTheme.subtitle1,
              labelColor: Theme.of(context).primaryColorLight,
            ),
          ),
          body: TabBarView(
            children: pages.map((e) => e.child).toList(),
          ),
        ),
      ),
    );
  }
}
