import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class UpdateItemDescription with ChangeNotifier {
  static UpdateItemDescription toUpdateItemDescription({
    DocumentReference reference,
    Map<String, dynamic> map,
    bool isDefault,
  }) {
    return UpdateItemDescription(
      text: TextEditingController.fromValue(
        TextEditingValue.fromJSON(
          map['text'],
        ),
      ),
      reference: reference,
      isDefault: isDefault,
    );
  }

  DocumentReference reference;
  TextEditingController text;
  bool isDefault;
  bool isChanges = false;
  UpdateItemDescription({
    this.reference,
    this.text,
    this.isDefault = false,
  });

  Future update() {
    return this.reference.set(
      {
        'text': text.value.text,
        "createAt": FieldValue.serverTimestamp(),
      }, 
      // merge: true,
    ).whenComplete(
      () => isChanges && isDefault
          ? reference.parent.doc('default').set({
              "text": text.value.text,
              "createAt": FieldValue.serverTimestamp(),
              "languageCode": reference.id,
            })
          : null,
    );
  }

  Future create() {
    return this.reference.set(
      {
        'text': text.value.text,
        "createAt": FieldValue.serverTimestamp(),
      },
      // merge: true,
    ).whenComplete(
      () => isChanges && isDefault
          ? reference.parent.doc('default').set({
              "text": text.value.text,
              "createAt": FieldValue.serverTimestamp(),
              "languageCode": reference.id,
            })
          : null,
    );
  }

  changeIsDefault() {
    isChanges = !isChanges;
    isDefault = !isDefault;
  }
}
