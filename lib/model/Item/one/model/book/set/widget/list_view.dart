import 'package:flutter/material.dart';
import 'package:hafeez/model/Item/one/model/book/one/widget/icon.dart';
import '../model/data.dart';

class ItemBooksListView extends StatelessWidget {
  const ItemBooksListView({Key key, @required this.books}) : super(key: key);
  final ItemBooks books;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      scrollDirection: Axis.horizontal,
      itemCount: books.list.length,
      itemBuilder: (context, index) {
        var book = books.list[index];

        return ItemBookIcon(
          book: book,
        );
      },
    );
  }
}
