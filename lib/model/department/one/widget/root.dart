import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../manament_status/ms_all.dart';
import '../model/data.dart';
import '../model/title/one/model/title.dart';
import '../../set/api/get.dart';
import '../screen/screen.dart';

class DepartmentWidgets {
  final Department data;

  DepartmentWidgets({@required this.data});

  // Tile
  Widget categoryTile() {
    return DepartmentCategoryTile(data: data);
  }

  void goToScreen(BuildContext context,
      {DepartmentTitle title, bool replacing = false}) {
    if (replacing)
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return DepartmentScreen(data: data, title: title);
        },
      ));
    else
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return DepartmentScreen(data: data, title: title);
        },
      ));
  }
}

class DepartmentCategoryTile extends StatelessWidget {
  const DepartmentCategoryTile({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Department data;

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagementState>(
      builder: (context, ManagementState managementState, _) =>
          data.title.widget(
              builder: (context, _title) {
                var status =
                    managementState.isDepartmentSelected(data.reference);
                return GestureDetector(
                  onTap: () {
                    managementState.addDepartment(data.reference);
                  },
                  child: Tooltip(
                    message: _title.text,
                    child: LimitedBox(
                      maxWidth: data.reference.id == "public" ? 100 : 200,
                      maxHeight: GetDepartments.maxRowHeight,
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: status
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                          // border: Border.all(color: status ? Theme.of(context).primaryColorLight : Colors.transparent),
                        ),
                        child: Center(
                          child: Text(
                            _title.text,
                            style: TextStyle(
                              color: status
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColorLight,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: LimitedBox(
                maxWidth: 300,
                maxHeight: GetDepartments.maxRowHeight,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              )),
    );
  }
}
