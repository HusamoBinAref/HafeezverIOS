import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/classes/database/firebase_selectors.dart';

class DefaultData {
  static words() async {
    var root = FirestoreSelectors.words;

    var word1 = root.doc('1');
    await word1.set({'createAt': Timestamp.now()}).then((value) async {
      var titles = word1.collection('Title');

      await titles.doc('ar').set({'text': 'الكلمة الاولى'});
    });

    var word2 = root.doc('2');
    await word2.set({'createAt': Timestamp.now()}).then((value) async {
      var titles = word2.collection('Title');

      await titles.doc('ar').set({'text': 'الكلمة الثانية'});
    });

    var word3 = root.doc('3');
    await word3.set({'createAt': Timestamp.now()}).then((value) async {
      var titles = word3.collection('Title');

      await titles.doc('ar').set({'text': 'الكلمة الثالثة'});
    });

    var word4 = root.doc('4');
    await word4.set({'createAt': Timestamp.now()}).then((value) async {
      var titles = word4.collection('Title');

      await titles.doc('ar').set({'text': 'الكلمة الرابعة'});
    });
  }
}
