import 'package:firebase_storage/firebase_storage.dart';

class StorageManagerCommends {
  static final FirebaseStorage storage = FirebaseStorage.instance;
  static StorageReference user(String userID) => storage.ref().child('User').child(userID);
  static StorageReference items(String userID) => user(userID).child("Item");
  static StorageReference item(String userID, String itemID) => items(userID).child(itemID);
  static StorageReference itemImages(String userID, String itemID) =>
      item(userID, itemID).child('Image');
}
