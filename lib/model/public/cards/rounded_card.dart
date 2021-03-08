import 'package:flutter/material.dart'
    show
        BorderRadius,
        BuildContext,
        Card,
        ClipRRect,
        Color,
        Container,
        EdgeInsets,
        Key,
        RoundedRectangleBorder,
        StatelessWidget,
        Widget;

class RoundedCard extends StatelessWidget {
  const RoundedCard({
    Key key,
    this.child,
    this.borderRadius,
    this.margin,
    this.color,
    this.elevation = 1,
    this.shadowColor,
  }) : super(key: key);

  final Widget child;
  final BorderRadius borderRadius;
  final double elevation;
  final EdgeInsets margin;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color ?? null,
      shadowColor: shadowColor,
      margin: margin != null
          ? margin
          : const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius:
            borderRadius != null ? borderRadius : BorderRadius.circular(3),
      ),
      child: ClipRRect(
        borderRadius:
            borderRadius != null ? borderRadius : BorderRadius.circular(3),
        child: child != null ? child : Container(),
      ),
    );
  }
}
