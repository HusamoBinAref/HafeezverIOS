import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hafeez/classes/tools/check.dart';
import 'package:hafeez/model/account/one/model/information/model/dead.dart';
import 'package:hafeez/model/account/one/widget/components/EdittingListTile.dart';

import '../../../../../../generated/l10n.dart';

class GetDead {
  final DocumentReference reference;
  GetDead({
    this.reference,
  });

  Stream<Dead> stream({Dead initialPrith}) => reference.snapshots().map((_prith) {
        if (_prith.exists)
          return Dead.toPrith(_prith);
        else
          return initialPrith;
      });

  Widget widget(
    Function(BuildContext context, Dead prith) builder, {
    Widget child,
    Dead deadData,
  }) {
    return StreamBuilder<Dead>(
        initialData: deadData,
        stream: stream(initialPrith: deadData),
        builder: (context, _prith) {
          if (Check.asyncSnapshot(_prith)) {
            return builder(context, _prith.data);
          } else
            return child == null ? Container() : child;
        });
  }

  Widget row() => this.widget((context, prith) => Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller:
                    TextEditingController.fromValue(TextEditingValue(text: prith.prithDateString)),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: S.of(context).account_prith_date,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 4,
                      color: Theme.of(context).appBarTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller:
                    TextEditingController.fromValue(TextEditingValue(text: prith.prithLocation)),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: S.of(context).account_prith_location,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 4,
                      color: Theme.of(context).appBarTheme.color,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ));
  Widget edittingDate() {
    return this.widget(
      (context, prith) => EdittingListTile(
        title: prith.prithDateString,
        subTitle: S.of(context).account_prith_date,
        iconData: Icons.date_range,
        onTap: () {
          showDatePicker(
            useRootNavigator: true,
            context: context,
            initialDate: prith.prithDate ?? DateTime.now(),
            firstDate: DateTime.parse("1500-01-01"),
            lastDate: DateTime.now(),
            fieldLabelText: S.of(context).account_dead_date,
          ).then(
            (value) {
              if (value != prith.prithDate) {
                prith.reference.set({'date': Timestamp.fromDate(value)}, SetOptions(merge: true));
              }
            },
          ).catchError((onError) {});
        },
      ),
      deadData: Dead(reference: this.reference, map: {}),
    );
  }

  Widget edittingLocation() {
    return this.widget(
      (context, prith) => EdittingListTile(
        title: prith.prithLocation,
        subTitle: S.of(context).account_dead_location,
        iconData: Icons.location_on,
        onTap: () {
          showBottomSheet(
              context: context,
              builder: (ctx) {
                return Container();
              });
        },
      ),
      deadData: Dead(reference: this.reference, map: {}),
    );
  }

  Widget showAll(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).primaryColorLight,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.of(context).account_dead,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        this.edittingDate(),
        this.edittingLocation(),
      ],
    );
  }
}
