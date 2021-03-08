// import 'package:flutter/material.dart';
// import 'package:hafeez/classes/routing/api/screens.dart';
// import 'package:hafeez/generated/l10n.dart';
// import 'package:hafeez/model/Item/one/model/data.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// import 'model/Employee_data_source.dart';

// /// The home page of the application which hosts the datagrid.
// class MyDataGrid extends StatelessWidget {
//   static navigator(BuildContext context, List<ITem> items) {
//     ScreenRouting.navigator(context,
//         child: MyDataGrid(
//           itemsDataSource: ItemDataSource(items: items),
//         ));
//   }

//   /// Creates the home page.
//   MyDataGrid({Key key, this.itemsDataSource}) : super(key: key);
//   final ItemDataSource itemsDataSource;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SfDataGrid(
//         source: itemsDataSource,
//         columns: <GridColumn>[
//           GridWidgetColumn(
//             mappingName: 'title',
//             headerText: S.of(context).item_title,
//             columnWidthMode: ColumnWidthMode.fill,
//           ),
//           GridTextColumn(
//               allowSorting: true,
//               mappingName: 'type',
//               headerText: S.of(context).titles,
//               softWrap: true,
//               overflow: TextOverflow.clip),
//           GridTextColumn(
//               allowSorting: true,
//               mappingName: 'createAt',
//               headerText: S.of(context).create_at,
//               overflow: TextOverflow.clip),
//         ],
//       ),
//     );
//   }
// }
