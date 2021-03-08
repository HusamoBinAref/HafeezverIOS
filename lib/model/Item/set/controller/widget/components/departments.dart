import 'package:flutter/material.dart';
import 'package:hafeez/generated/l10n.dart';
import '../../model/data.dart';

class DepartmentsWidget extends StatefulWidget {
  final ItemModel model;
  const DepartmentsWidget({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  _DepartmentsWidgetState createState() => _DepartmentsWidgetState();
}

class _DepartmentsWidgetState extends State<DepartmentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.model.formKeys[2],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                return widget.model.selectedDepartments
                        .where((element) => element.isSelected)
                        .isNotEmpty
                    ? null
                    : S.of(context).select_one_department_or_more;
              },
              autofocus: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                hoverColor: Theme.of(context).primaryColorLight,
                focusColor: Theme.of(context).primaryColorLight,
                alignLabelWithHint: true,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelStyle: Theme.of(context).textTheme.subtitle1,
                filled: true,
                labelText: S.of(context).search,
                suffixIcon: Icon(Icons.search, color: Theme.of(context).primaryColorLight),
              ),
              controller: widget.model.searchDepartmentController,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              cacheExtent: 100,
              itemCount: widget.model.departmentsList.departments.length,
              itemBuilder: (context, index) {
                var department = widget.model.departmentsList.departments[index];
                return department.title.widget(builder: (context, title) {
                  var searchDepartmentText = widget.model.searchDepartmentController.value.text;
                  if (searchDepartmentText.isEmpty || title.text.contains(searchDepartmentText))
                    return title.widgets.selectionTile(context, department: department,
                        refresh: () {
                      setState(() {});
                    });
                  else
                    return Container();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
