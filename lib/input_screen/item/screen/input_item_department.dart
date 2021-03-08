import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/input_screen/item/controller/item.dart';
import 'package:hafeez/input_screen/item/widget/row_title_and_tow_buttons.dart';
import 'package:hafeez/model/department/set/api/get.dart';
import 'package:provider/provider.dart';

class InputItemDepartments extends StatelessWidget {
  const InputItemDepartments({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(
        builder: (context, ItemController controller, _) {
      return Scaffold(
        body: Scaffold(
          body: Column(
            children: [
            RowTitleAndTowButtons(
              title: S.of(context).departments,
              btnBackFunction: controller.backStep,
              btnNextFunction: controller.nextStep,
            ),
              Expanded(child: GetDepartments.build.widget(
                (context, departments) {
                  departments.departments.removeWhere(
                      (element) => element.reference.id == "public");
                  return ListView.builder(
                    itemCount: departments.departments.length,
                    itemBuilder: (context, index) {
                      var department = departments.departments[index];
                      var isSelected =
                          controller.departments.contains(department.reference);
                      return Card(
                        color: isSelected
                            ? Theme.of(context).primaryColorDark
                            : null,
                        child: ListTile(
                          onTap: () {
                            if (isSelected)
                              controller.deleteDepartment(department.reference);
                            else
                              controller.addDepartment(department.reference);
                          },
                          selected: isSelected,
                          title: department.title.widget(
                            builder: (context, title) {
                              return Text(
                                title.text,
                                style: TextStyle(
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).primaryColorDark),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      );
    });
  }
}
