import 'package:flutter/material.dart'
    show
        AspectRatio,
        BuildContext,
        Card,
        Color,
        Column,
        Container,
        InkWell,
        Key,
        MainAxisAlignment,
        StatelessWidget,
        Text,
        Widget;

class CardReport extends StatelessWidget {
  const CardReport({
    Key key,
    this.title,
    this.value,
    this.onTap,
    this.width = 150,
    this.color,
  }) : super(key: key);
  final String title;
  final String value;
  final Function onTap;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color != null ? color.withOpacity(0.7) : color,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title),
                Text(value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
