// import 'package:flutter/material.dart';
// import 'package:hafeez/model/Item/one/model/data.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

// /// An object to set the employee collection data source to the datagrid. This
// /// is used to map the employee data to the datagrid widget.
// class ItemDataSource extends DataGridSource<ITem> {
//   final List<ITem> items;

//   ItemDataSource({@required this.items});

//   @override
//   List<ITem> get dataSource => items;

//   @override
//   Object getValue(ITem item, String columnName) {
//     switch (columnName) {
//       case 'createAt':
//         return item.createString;
//         break;
//       case 'title':
//         return item.titles.widget((context, title) => Text(title.text));
//         break;
//       case 'type':
//         return item.type;
//         break;
//       case 'description':
//         return item.descriptions
//             .widget((context, description) => Text(description.text));
//         break;
//       case 'image':
//         return item.image.widget((context, itemImage) => itemImage.widgets.hero(width: 100,height: 100));
//         break;
//       default:
//         return ' ';
//         break;
//     }
//   }

// }
