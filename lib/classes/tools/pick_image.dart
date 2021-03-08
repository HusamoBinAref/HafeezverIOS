import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class API_Image {
  static Future<File> pickImageFromPhone() async {
    // ignore: deprecated_member_use
    File image;

    try {
      // ignore: deprecated_member_use
      image = await ImagePicker.pickImage(source: ImageSource.gallery);

      return await cropImage(image);
    } catch (e) {
      return null;
    }
  }

  /// get image form camara
  static Future<File> pickImageFromCamera() async {
    File image;

    try {
      // ignore: deprecated_member_use
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      return await cropImage(image);
    } catch (e) {
      return null;
    }
    // ignore: deprecated_member_use
  }

  /// crop image ...
  static Future<File> cropImage(File image) async {
    try {
      return await ImageCropper.cropImage(
          sourcePath: image.path,
          compressQuality: 100,
          compressFormat: ImageCompressFormat.jpg,
          aspectRatioPresets: [CropAspectRatioPreset.square]);
    } catch (e) {
      return null;
    }
  }
}
