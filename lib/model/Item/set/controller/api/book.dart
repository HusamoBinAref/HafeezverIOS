import 'package:flutter/material.dart';

import '../widget/root.dart';

class BookFunctions {
  static Future<void> addBookLink(BuildContext context,
      {Function closing}) async {
    String bookUrl = await showDialog(
        context: context,
        child: Builder(
          builder: (context) {
            return Dialog(child: BookDialog());
          },
        ));

    if (bookUrl != null && bookUrl.isNotEmpty && bookUrl[0] != "") {
      ItemAddWidgets.book(
        context,
        bookUrl: bookUrl[0],
      );
    }
  }
}

class BookDialog extends StatelessWidget {
  const BookDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController url = TextEditingController();
    return Container(
        height: 100,
        child: Column(
          children: [
            TextFormField(
              controller: url,
            ),
            Row(
              children: [
                RaisedButton(
                  child: Text("next"),
                  onPressed: () {
                    Navigator.pop(context, [url.value.text]);
                  },
                )
              ],
            ),
          ],
        ));
  }
}
