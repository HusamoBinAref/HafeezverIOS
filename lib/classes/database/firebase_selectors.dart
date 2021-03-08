import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hafeez/classes/commends/key_words.dart';

class FirestoreSelectors {
  //
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static CollectionReference user = db.collection("User");

// items
  static Query rootItems = db.collectionGroup("Item");

  static CollectionReference items(DocumentReference userReference) =>
      userReference.collection("Item");

  static CollectionReference itemBooks(DocumentReference itemReference) =>
      itemReference.collection(KeyWords.itemKeyWords[0]);

  static CollectionReference itemVideos(DocumentReference itemReference) =>
      itemReference.collection(KeyWords.itemKeyWords[2]);

  static CollectionReference itemAudios(DocumentReference itemReference) =>
      itemReference.collection("Audio");

  //
  // static CollectionReference book = db.collection("Book");

  //
  static CollectionReference specialization = db.collection("Specialization");

  //
  static CollectionReference departments = db.collection("Department");

  //
  static CollectionReference words = db.collection("Word");

  //
  static CollectionReference languages = db.collection('Language'); 

  static Query favorites = db.collectionGroup("Favorite");

  //
  static CollectionReference favoritesByAccount(
          DocumentReference urseReference) =>
      urseReference.collection("Favorite");

  //
  static Query titles = db.collectionGroup("Title");
}
