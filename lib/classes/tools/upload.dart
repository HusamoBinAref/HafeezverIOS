import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/commends/storage.dart';

class UpLoadFile {
  static Future<StorageReference> file({
    @required BuildContext context,
    @required File file,
    @required String path,
    Function(double value) refreshProgress,
  }) async {
    try {
      final StorageReference storageReference = StorageManagerCommends.storage.ref().child(path);

      final StorageUploadTask uploadTask = storageReference.putFile(file);

      final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
        var totalBytes = event.snapshot.totalByteCount;
        var transferred = event.snapshot.bytesTransferred;

        print((totalBytes.toString() + "totalBytes......"));
        print((transferred.toString() + "transferred......"));
        refreshProgress(((transferred * 1.0).toDouble() / totalBytes));
      });

      StorageTaskSnapshot onComplete = await uploadTask.onComplete;

      StorageReference reference = onComplete.ref;

      streamSubscription.cancel();

      return reference;
    } catch (e) {
      return null;
    }
  }
}
