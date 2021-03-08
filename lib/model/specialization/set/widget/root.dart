import 'package:flutter/material.dart';
import 'package:hafeez/model/specialization/set/api/get.dart';
import '../model/data.dart';

class SpecailizationsWidgets {
  final Specializations data;

  SpecailizationsWidgets({@required this.data});

  Widget listrow(BuildContext context) {
    data.specializations.removeWhere((element) => element.reference.id.contains('public'));
    return ListView.builder(
        itemCount: data.specializations.length,
        itemBuilder: (context, index) {
          var specialization = data.specializations[index];
          return specialization.title.widget(builder: (context, title) {
            return Card(
                child: ListTile(
                    title: Text(title.text),
                    onTap: () {
                      specialization.goToScreen(context);
                    }));
          });
        });
  }

  Widget row(BuildContext context) {
    return LimitedBox(
      maxHeight: GetSpecializations.maxRowHeight + 20,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20 / 2, horizontal: 10),
        child: ListView.separated(
          cacheExtent: 100,
          scrollDirection: Axis.horizontal,
          itemCount: data.specializations.length,
          itemBuilder: (context, i) {
            return data.specializations[i].categoryTile(context,
                primaryColor: Theme.of(context).primaryColorLight,
                secondryColor: Theme.of(context).primaryColor);
          },
          separatorBuilder: (context, i) => Container(
              height: GetSpecializations.maxRowHeight + 20,
              color: Theme.of(context).primaryColorLight,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: 5)),
        ),
      ),
    );
  }
}
