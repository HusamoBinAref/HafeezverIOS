// import 'package:flutter/material.dart'
//     show
//         AppBar,
//         BuildContext,
//         Icon,
//         IconButton,
//         Icons,
//         Key,
//         ListView,
//         Scaffold,
//         StatelessWidget,
//         Text,
//         Widget,
//         required;

// import 'package:hafeez/classes/routing/api/screens.dart';
// import 'package:hafeez/model/account/set/model/data.dart';
// import 'package:hafeez/model/report/model/data.dart';
// import 'package:hafeez/model/report/widget/accounts/report_account_card.dart';
// import 'package:hafeez/model/report/widget/time_picker.dart';
// import 'package:provider/provider.dart';

// import '../report_date_unit_type_pop_up.dart';

// class ReportAccountsScreen extends StatelessWidget {
//   static navigator(BuildContext context,
//       {@required Accounts accounts, @required String title}) {
//     var reportInfo2 = Provider.of<ReportInfo>(context, listen: false);
//     ScreenRouting.navigator(
//       context,
//       child: ChangeNotifierProvider<ReportInfo>(
//           create: (context) => ReportInfo(
//               startDate: reportInfo2.start, endDate: reportInfo2.end),
//           builder: (context, snapshot) {
//             return ReportAccountsScreen(accounts: accounts, title: title);
//           }),
//     );
//   }

//   const ReportAccountsScreen({
//     Key key,
//     @required this.accounts,
//     this.title = "",
//   }) : super(key: key);

//   final Accounts accounts;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<ReportInfo>(builder: (context, reportInfo, _) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(title),
//             actions: [
//               ReportDateUnitTypePopUp(
//                 reportInfo: reportInfo,
//               ),
//               IconButton(
//                   icon: Icon(Icons.calendar_today_rounded),
//                   onPressed: () {
//                     ScreenRouting.myShowDialog(context,
//                         child: ReportDatePicker(report: reportInfo));
//                   }),
//             ],
//           ),
//           body: ListView.builder(
//               itemExtent: 80,
//               itemCount: accounts.accounts.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var account = accounts.accounts[index];
//                 return ReportAccountCard(account: account);
//               }),
//         );
//       }),
//     );
//   }
// }
