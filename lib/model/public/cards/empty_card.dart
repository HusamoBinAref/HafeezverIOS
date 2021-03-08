import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        Colors,
        Container,
        EdgeInsets,
        Key,
        StatelessWidget,
        Widget,
        required;

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: Colors.transparent,
      child: child != null ? child : Container(),
    );
  }
}
