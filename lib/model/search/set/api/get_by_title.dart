// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hafeez/api/firebase_selectors.dart';

// import 'package:hafeez/model/search/set/model/data.dart';

// class GetItemsByTitle {
//   static GetItemsByTitle build({
//     @required String title,
//     @required List<String> types,
//     int count = 10,
//   }) {
//     return GetItemsByTitle(
//         reference: FirestoreSelectors.titles
//             // .orderBy('text')
//             .where('text', isGreaterThanOrEqualTo: title)
//             // .where("type", whereIn: types.isNotEmpty ? types : KeyWords.itemKeyWords)
//             .limit(count));
//   }

//   final Query reference;

//   GetItemsByTitle({@required this.reference});

//   Stream<SearchResults> get stream => reference.snapshots().map(SearchResults.build);

//   Widget widget(Widget Function(BuildContext context, SearchResults searchResults) builder) {
//     return StreamBuilder<SearchResults>(
//       initialData: SearchResults(results: []),
//       stream: stream,
//       builder: (context, result) {
//         if (result.hasData)
//           return builder(context, result.data);
//         else
//           return builder(context, SearchResults(results: []));
//       },
//     );
//   }
// }
