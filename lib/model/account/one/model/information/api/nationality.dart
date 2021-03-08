import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/information/model/nationality.dart';

class GetNationality {
  final DocumentReference reference;
  GetNationality({
    this.reference,
  });

  Stream<Nationality> stream({bool doDefault = false}) => reference.snapshots().map((_nationality) {
        if (_nationality.exists)
          return Nationality.toNationality(_nationality);
        else
          return doDefault ? Nationality.getDefault(_nationality.reference) : null;
      });

  Widget widget(Function(BuildContext context, Nationality nationality) builder,
      {Widget child, bool doDefault = false}) {
    return StreamBuilder<Nationality>(
        stream: stream(doDefault: doDefault),
        builder: (context, _nationality) {
          if (Check.asyncSnapshot(_nationality)) {
            return builder(context, _nationality.data);
          } else
            return child == null ? Container() : child;
        });
  }

  Widget editting() {
    return widget(
      (context, nationality) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Theme.of(context).primaryColorLight,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'الجنسيات',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (nationality.firstNationality != '')
                Expanded(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(nationality.firstNationality),
                    ),
                  ),
                ),
              if (nationality.secondNationality != '')
                Expanded(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(nationality.secondNationality),
                    ),
                  ),
                ),
              if (nationality.thirdNationality != '')
                Expanded(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(nationality.thirdNationality),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      doDefault: true,
    );
  }

  Widget view() {
    return widget(
      (context, nationality) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(height: 30, thickness: 3),
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'الجنسيات',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Row(
            children: [
              if (nationality.firstNationality != '')
                Expanded(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(nationality.firstNationality),
                    ),
                  ),
                ),
              if (nationality.secondNationality != '')
                Expanded(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(nationality.secondNationality),
                    ),
                  ),
                ),
              if (nationality.thirdNationality != '')
                Expanded(
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Text(nationality.thirdNationality),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
