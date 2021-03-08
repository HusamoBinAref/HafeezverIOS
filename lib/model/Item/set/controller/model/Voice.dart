import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hafeez/classes/tools/public_variables.dart';
import 'package:hafeez/generated/l10n.dart';

class VoiceModel {
  TextEditingController imageController = TextEditingController();
  String get imageUrl => imageController.value.text;
  File imageFile;
  TextEditingController voiceController = TextEditingController();
  String get voiceUrl => voiceController.value.text;
  File voiceFile;
  String title;

  VoiceModel({this.imageFile, this.voiceFile, this.title});

  Future<String> add(
    BuildContext context,
    DocumentReference itemReference, {
    Function(double value) imageProgress,
    Function(double value) voiceProgress,
  }) async {
    var imageRef = itemReference.collection("Image").doc("image");
    var voiceRef = itemReference.collection("Voice").doc(S.of(context).languageCode);
    try {
      if (imageUrl != null || imageFile != null) {
        if (imageFile != null) {
          var url =
              await MediaUpLoadFunctions.upLoading(context, path: imageRef.path, file: imageFile, refreshProgress: imageProgress);
          if (url != "error") {
            await imageRef.set({"url": url});
          }
        } else
          await imageRef.set({"url": imageUrl});
      }

      if (voiceUrl != null || voiceFile != null) {
        if (voiceFile != null) {
          var url =
              await MediaUpLoadFunctions.upLoading(context, path: voiceRef.path, file: voiceFile, refreshProgress: voiceProgress);
          if (url != "error") {
            await voiceRef.set({"url": url});
          }
        } else
          await voiceRef.set({"url": voiceUrl});
      }
      return "done";
    } catch (e) {
      return "error";
    }
  }
}
