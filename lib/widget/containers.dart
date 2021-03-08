import 'package:flutter/material.dart'
    show
        AlwaysStoppedAnimation,
        BuildContext,
        Center,
        CircularProgressIndicator,
        Color,
        Container,
        MediaQuery,
        Orientation,
        Theme,
        Widget;

import 'package:hafeez/classes/tools/public_variables.dart';

class Containers {
  static landspace(BuildContext context, {Widget child}) {
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      return Container(
        height: MediaCheckFunctions.height(context),
        child: child != null ? child : Container(),
      );
    else
      return child != null ? child : Container();
  }

  static Widget waitting(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColorLight),
    ));
  }
}
