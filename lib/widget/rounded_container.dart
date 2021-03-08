import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContainerRounded extends StatelessWidget {
  const ContainerRounded({
    Key key,
    this.child,
    this.padding = 20,
    this.margin,
    this.color,
    this.borderRadius = 12,
    this.elevation,
    this.width,
    this.top = 15,
    this.bottom = 10,
    this.left = 10,
    this.right = 10,
  }) : super(key: key);
  final Widget child;
  final double padding;

  final Color color;
  final double borderRadius;
  final double elevation;
  final double width;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final EdgeInsets margin;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      // margin: EdgeInsets.symmetric(horizontal: margin, vertical: 5),
      child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: color ?? Theme.of(context).primaryColorLight),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: EdgeInsets.only(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
          ),
          width: width,
          child: child),
    );
  }
}
