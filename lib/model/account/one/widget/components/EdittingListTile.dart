import 'package:flutter/material.dart';

class EdittingListTile extends StatelessWidget {
  const EdittingListTile({
    Key key,
    this.title = '',
    this.subTitle = '',
    this.onTap,
    this.iconData = Icons.timer,
    this.isOwner = true,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final IconData iconData;
  final Function() onTap;
  final bool isOwner;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(
          iconData,
          color: Theme.of(context).primaryColorLight,
        ),
        trailing: isOwner
            ? IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColorLight,
                ),
                onPressed: () {
                  onTap();
                },
              )
            : null,
        subtitle: Text(subTitle),
      ),
    );
  }
}
