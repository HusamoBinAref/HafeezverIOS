import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/classes/tools/public_variables.dart';

class NoItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaCheckFunctions.width(context) * 0.5,
        child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.asset(
              PlaceHolderImages.emptyImage,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            )),
      ),
    );
  }
}
