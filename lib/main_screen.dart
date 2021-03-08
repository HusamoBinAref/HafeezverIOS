import 'package:flutter/material.dart'
    show BuildContext, Drawer, Key, Scaffold, State, StatefulWidget, Widget;
import 'package:flutter/material.dart';
import 'package:hafeez/Details/detials_static.dart';

import 'classes/commends/selector.dart';

import 'model/public/drawer/drawer.dart';
import 'widget/grid_card.dart';
import 'widget/home_appbar.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedPageNo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar.appbar(
        context,
        onSelect: (pageNo) {
          if (pageNo != selectedPageNo)
            setState(() {
              selectedPageNo = pageNo;
            });
        },
        extreText: Selectors.title(context, selectedPageNo),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          GridCard(
              pageNo: 0,
              iconData: DetailsCollections.shiekhs(context).iconData,
              cardText: DetailsCollections.shiekhs(context).text),
          GridCard(
              pageNo: 1,
              iconData: DetailsCollections.departments(context).iconData,
              cardText: DetailsCollections.departments(context).text),
          GridCard(
              pageNo: 2,
              iconData: DetailsCollections.posts(context).iconData,
              cardText: DetailsCollections.posts(context).text),
          GridCard(
            pageNo: 3,
            iconData: DetailsCollections.books(context).iconData,
            cardText: DetailsCollections.books(context).text,
          ),
          GridCard(
              pageNo: 4,
              iconData: DetailsCollections.videos(context).iconData,
              cardText: DetailsCollections.videos(context).text),
          GridCard(
              pageNo: 5,
              iconData: DetailsCollections.voices(context).iconData,
              cardText: DetailsCollections.voices(context).text),
        ],
      ),
    );
  }
}
