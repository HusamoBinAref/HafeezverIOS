import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Card,
        Colors,
        EdgeInsets,
        Hero,
        ListTile,
        ListView,
        RoundedRectangleBorder,
        Text,
        Theme,
        Widget;
import 'package:hafeez/model/word/set/model/data.dart';

class WordsWidgets {
  final Words data;

  WordsWidgets({@required this.data});

  Widget list(BuildContext context) {
    data.words.removeWhere((word) => word.reference.id.contains('public'));
    return ListView.builder(
      itemCount: data.words.length,
      cacheExtent: 40,
      itemBuilder: (context, index) {
        var word = data.words[index];
        return word.title.widget(
          builder: (context, departmentTitle) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: ListTile(
              title: Hero(
                tag: word.reference.path,
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Text(
                    departmentTitle.text,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        );
      },
    );
  }
}
