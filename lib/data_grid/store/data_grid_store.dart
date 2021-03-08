import 'package:flutter/material.dart';
import 'package:hafeez/data_grid/model/empolyee_data.dart';

final Map<String, Object> _employeesMap = <String, Object>{
  "1": <String, Object>{
    "groupNum": 0,
    "employees": <Employee>[],
  },
};

List<Employee> getEmployees({@required String id}) {
  return List<Employee>.from(
      (_employeesMap[id] as Map<String, Object>)["employees"]);
}

void setEmployees({@required String id, @required List<Employee> list}) {
  ((_employeesMap[id] as Map<String, Object>)["employees"] as List<Employee>)
      .addAll(list);
}

int getGroupNum({@required String id}) {
  return (_employeesMap[id] as Map<String, Object>)["groupNum"];
}

void setGroupNum({@required String id, @required int value}) {
  (_employeesMap[id] as Map<String, Object>)["groupNum"] = value;
}

void populateData() {
  if (getGroupNum(id: "1") == 0) {
    setGroupNum(id: "1", value: 1);
    setEmployees(id: "1", list: <Employee>[
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000),
    ]);
  }
}
