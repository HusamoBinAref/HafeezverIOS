import 'package:flutter/material.dart';

class RowTitleAndTowButtons extends StatelessWidget {
  const RowTitleAndTowButtons({
    Key key,
    this.btnBackFunction,
    this.btnNextFunction,
    @required this.title,
  }) : super(key: key);
  final Function btnBackFunction;
  final Function btnNextFunction;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.navigate_before,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    btnBackFunction();
                  }),
            ),
            Expanded(
                flex: 8,
                child: Center(
                  child: Text(title,
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                )),
            Expanded(
              child: IconButton(
                  icon: Icon(Icons.navigate_next,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    btnNextFunction();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
