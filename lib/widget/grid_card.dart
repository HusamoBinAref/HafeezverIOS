import 'package:flutter/material.dart'
    show
        AppBar,
        AspectRatio,
        BuildContext,
        Card,
        Center,
        Colors,
        Container,
        Drawer,
        EdgeInsets,
        Hero,
        Icon,
        IconButton,
        IconData,
        Icons,
        Key,
        ListTile,
        MainAxisAlignment,
        Navigator,
        Padding,
        Row,
        SafeArea,
        Scaffold,
        StatelessWidget,
        Text,
        Theme,
        Widget,
        required;
import 'package:hafeez/Details/detials_static.dart';

import 'package:hafeez/classes/commends/selector.dart';
import 'package:hafeez/classes/routing/api/screens.dart';
import 'package:hafeez/model/public/drawer/drawer.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    Key key,
    @required this.pageNo,
    @required this.cardText,
    @required this.iconData,
  }) : super(key: key);
  final int pageNo;
  final String cardText;
  final IconData iconData;
  String title(BuildContext context) {
    if (pageNo == 0)
      return DetailsCollections.shiekhs(context).text;
    else if (pageNo == 1)
      return DetailsCollections.departments(context).text;
    else if (pageNo == 2)
      return DetailsCollections.posts(context).text;
    else if (pageNo == 3)
      return DetailsCollections.books(context).text;
    else if (pageNo == 4)
      return DetailsCollections.videos(context).text;
    else if (pageNo == 5)
      return DetailsCollections.voices(context).text;
    else
      return DetailsCollections.voices(context).text;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        ScreenRouting.navigator(
          context,
          child: TileToScreen(
            iconData: iconData,
            pageNo: pageNo,
          ),
        );
      },
      leading: Hero(
        tag: title(context) + "/icon",
        child: Card(
          color: Theme.of(context).primaryColorLight.withOpacity(0.15),
          margin: const EdgeInsets.all(0),
          elevation: 0,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              height: 60,
              child: Icon(
                iconData,
                color: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
      title: Hero(
        tag: title(context) + "/title",
        child: Card(
          margin: const EdgeInsets.all(0),
          color: Theme.of(context).primaryColorLight.withOpacity(0.15),
          elevation: 0,
          child: Container(
            height: 60,
            child: Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Text(
                  cardText,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TileToScreen extends StatelessWidget {
  const TileToScreen({
    Key key,
    @required this.iconData,
    @required this.pageNo,
  }) : super(key: key);

  final IconData iconData;
  final int pageNo;

  String title(BuildContext context) {
    if (pageNo == 0)
      return DetailsCollections.shiekhs(context).text;
    else if (pageNo == 1)
      return DetailsCollections.departments(context).text;
    else if (pageNo == 2)
      return DetailsCollections.posts(context).text;
    else if (pageNo == 3)
      return DetailsCollections.books(context).text;
    else if (pageNo == 4)
      return DetailsCollections.videos(context).text;
    else if (pageNo == 5)
      return DetailsCollections.voices(context).text;
    else
      return DetailsCollections.voices(context).text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: title(context) + "/icon",
              child: Card(
                margin: const EdgeInsets.all(0),
                color: Colors.transparent,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    iconData,
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
              ),
            ),
            Hero(
              tag: title(context) + "/title",
              child: Card(
                color: Colors.transparent,
                margin: const EdgeInsets.all(0),
                elevation: 0,
                child: Text(
                  title(context),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: SafeArea(
        child: Selectors.main(pageNo),
      ),
    );
  }
}
