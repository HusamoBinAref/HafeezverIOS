import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/account/one/model/favorite/set/model/data.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key key, @required this.favorites}) : super(key: key);
  final Favorites favorites;

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int pageNo = 0;

  isSelected(int index) {
    return index == pageNo;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
      initialIndex: 0,
      length: 5, 
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TabBar(
            isScrollable: true,
            tabs: [
              Text(S.of(context).sheikhs),
              // Text(S.of(context).departments),
              Text(S.of(context).books),
              Text(S.of(context).posts),
              Text(S.of(context).videos),
              Text(S.of(context).voices),
            ],
            onTap: (index) {
              setState(() {
                pageNo = index;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            widget.favorites.widgetsBySheikhs.grid(context),
            // widget.favorites.widgetsByDepartments.grid(context),
            widget.favorites.widgetsByBooks.grid(context),
            widget.favorites.widgetsByPosts.grid(context),
            widget.favorites.widgetsByVideos.grid(context),
            widget.favorites.widgetsByVoices.grid(context),
          ],
        ),
      ),
    ));
  }
}
