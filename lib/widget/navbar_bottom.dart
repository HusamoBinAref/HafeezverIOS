// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class BottomNavbar extends StatefulWidget {
//   BottomNavbar({
//     Key key,
//     this.pages,
//     this.pageNo,
//   }) : super(key: key);
//   final List<Map<String, Object>> pages;
//   int pageNo;
 
//   @override
//   _BottomNavbarState createState() => _BottomNavbarState();
// }

// class _BottomNavbarState extends State<BottomNavbar> {
//   GlobalKey _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         bottomNavigationBar: CurvedNavigationBar(
//           color: Theme.of(context).primaryColor,
//           backgroundColor: Theme.of(context).primaryColorLight,
//           key: _bottomNavigationKey,
//           index: widget.pageNo,
//           height: 60.0,
//           items: widget.pages
//               .map(
//                 (iconPage) => Icon(
//                   iconPage['Icon'],
//                   size: 30,
//                   color: Theme.of(context).primaryColorLight,
//                 ),
//               )
//               .toList(),
//           animationCurve: Curves.decelerate,
//           animationDuration: Duration(milliseconds: 500),
//           onTap: (index) {
//             setState(() {
//               widget.pageNo = index;
//             });
//           },
//         ),
//         body: Container(
//           height: double.infinity,
//           child: Scaffold(
//             body: widget.pages[widget.pageNo]['Page'],
//           ),
//         ));
//   }
// }
