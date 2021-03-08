import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';

class FieldsMenu extends StatelessWidget {
  const FieldsMenu({Key key, this.onSelect}) : super(key: key);
  final Function(int pageNo) onSelect;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: Icon(Icons.more_vert),
      onSelected: (int result) {
        onSelect(result);
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            value: 0,
            child: ListTile(
              leading: Icon(
                Icons.people,
                color: Theme.of(context).primaryColorLight,
              ),
              title: Text(
                S.of(context).sheikhs,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: ListTile(
              leading: Icon(
                Icons.grid_on,
                color: Theme.of(context).primaryColorLight,
              ),
              title: Text(
                S.of(context).departments,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: ListTile(
              leading: Icon(
                Icons.library_books,
                color: Theme.of(context).primaryColorLight,
              ),
              title: Text(
                S.of(context).posts,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: ListTile(
              leading: Icon(
                Icons.book,
                color: Theme.of(context).primaryColorLight,
              ),
              title: Text(
                S.of(context).books,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 4,
            child: ListTile(
              leading: Icon(
                Icons.videocam,
                color: Theme.of(context).primaryColorLight,
              ),
              title: Text(
                S.of(context).videos,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          PopupMenuItem<int>(
            value: 5,
            child: ListTile(
              leading: Icon(
                Icons.keyboard_voice,
                color: Theme.of(context).primaryColorLight,
              ),
              title: Text(
                S.of(context).voices,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
        ];
      },
    );
  }
}
