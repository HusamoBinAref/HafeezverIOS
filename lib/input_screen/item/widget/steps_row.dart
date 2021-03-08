// import 'package:flutter/material.dart';
// import 'package:steps/steps.dart';

// class StepsRow extends StatelessWidget {
//   const StepsRow({Key key, this.stepNo = 0, this.count = 3}) : super(key: key);
//   final int stepNo;
//   final int count;

//   List<int> get getStepsCount {
//     List<int> _steps = <int>[];
//     for (var i = 0; i < count; i++) {
//       _steps.add(i);
//     }
//     return _steps;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.topCenter,
//       height: 80,
//       child: Steps(
//         // size: 30.0,
//         direction: Axis.horizontal,
//         path: {
//           'color': Theme.of(context).primaryColorLight,
//           'width': 3.0,
//         },
//         steps: getStepsCount
//             .map(
//               (step) => {
//                 'color': Colors.white,
//                 'background': stepNo != step
//                     ? Theme.of(context).primaryColorLight
//                     : Theme.of(context).primaryColorDark,
//                 'label': (step + 1).toString(),
//                 'content': Container()
//               },
//             )
//             .toList(),
//       ),
//     );
//   }
// }
