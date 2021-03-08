import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/placeholder.dart';
import 'package:hafeez/classes/tools/pick_image.dart';
import 'package:hafeez/classes/tools/upload.dart';
import 'package:hafeez/generated/l10n.dart';
import 'package:hafeez/model/authentication/api/authentication.dart';
import 'package:hafeez/model/department/one/api/department.dart';
import 'package:hafeez/model/language/one/model/data.dart';
import 'package:hafeez/model/public/cards/rounded_card.dart';
import 'package:hafeez/model/word/api/word.dart';
import 'package:hafeez/widget/cache_image_widgets.dart';

import 'audio.dart';
import 'book.dart';
import 'description.dart';
import 'image.dart';
import 'title.dart';
import 'video.dart';

class ItemController with ChangeNotifier {
// type of item
  String _type;

  String get type => _type;
  set type(String typeValue) {
    if (typeValue != null && typeValue != "") {
      _type = typeValue;
      notifyListeners();
    }
  }

// step no
  int _step = 0;
  int get step => _step;
  set step(int value) {
    if (value != null && value > -1) {
      _step = value;
      notifyListeners();
    }
  }

  void nextStep() {
    {
      _step++;
      notifyListeners();
    }
  }

  void backStep() {
    if (_step > 0) {
      _step--;
      notifyListeners();
    }
  }

// titles
  List<TitleController> _titles = <TitleController>[];
  List<TitleController> get titles => _titles;
  void addTitle(Language documentReference) {
    if (documentReference != null &&
        !_titles.contains((TitleController element) =>
            element.language.reference == documentReference.reference)) {
      _titles.add(TitleController(language: documentReference));
      notifyListeners();
    }
  }

  void deleteTitle(Language documentReference) {
    if (documentReference != null &&
        _titles.contains((TitleController element) =>
            element.language.reference == documentReference.reference)) {
      _titles.removeWhere((element) =>
          element.language.reference == documentReference.reference);
      notifyListeners();
    }
  }

  static int titleLength = 300;
  List<Widget> getTitles(BuildContext context,
      {bool isEnable = true, int maxLines = 4}) {
    return titles.map((title) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLength: ItemController.titleLength,
            minLines: 1,
            maxLines: maxLines,
            enabled: isEnable,
            maxLengthEnforced: true,
            controller: title.controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              labelStyle: Theme.of(context).textTheme.subtitle1,
              labelText: title.language.name,
              focusColor: Theme.of(context).primaryColorLight,
              icon: CircleAvatar(
                maxRadius: 20,
                child: title.language.iconWidget(context),
              ),
            ),
            validator: (text) {
              if (text.trim().length < 10)
                return S.of(context).ten_cher_or_more;
              else
                return null;
            },
          ),
        ),
      );
    }).toList();
  }

// description
  List<DescriptionController> _descriptions = <DescriptionController>[];
  List<DescriptionController> get descriptions => _descriptions;
  void addDescription(Language language) {
    if (language != null &&
        !_descriptions.contains((DescriptionController element) =>
            element.language.reference == language.reference)) {
      _descriptions.add(DescriptionController(language: language));
      notifyListeners();
    }
  }

  void deleteDescription(Language language) {
    if (language != null &&
        _descriptions.contains((DescriptionController element) =>
            element.language.reference == language.reference)) {
      _descriptions.removeWhere(
          (element) => element.language.reference == language.reference);
      notifyListeners();
    }
  }

  static int descriptionLength = 400000;

  List<Widget> getDescriptions(BuildContext context,
      {bool isEnable = true, int maxLines = 4}) {
    return descriptions.map((description) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            maxLength: ItemController.descriptionLength,
            minLines: 1,
            maxLines: maxLines,
            enabled: isEnable,
            maxLengthEnforced: true,
            controller: description.controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              labelStyle: Theme.of(context).textTheme.subtitle1,
              labelText: description.language.name,
              focusColor: Theme.of(context).primaryColorLight,
              icon: CircleAvatar(
                maxRadius: 20,
                child: description.language.iconWidget(context),
              ),
            ),
            validator: (text) {
              if (text.trim().length < 10)
                return S.of(context).ten_cher_or_more;
              else
                return null;
            },
          ),
        ),
      );
    }).toList();
  }

// departments
  List<DocumentReference> _departments = <DocumentReference>[];
  List<DocumentReference> get departments => _departments;
  void addDepartment(DocumentReference documentReference) {
    if (documentReference != null &&
        !_departments.contains(documentReference)) {
      _departments.add(documentReference);
      notifyListeners();
    }
  }

  void deleteDepartment(DocumentReference documentReference) {
    if (documentReference != null && _departments.contains(documentReference)) {
      _departments.remove(documentReference);
      notifyListeners();
    }
  }

  List<Widget> getDepartments(BuildContext context) {
    return departments
        .map((department) => GetDepartment(reference: department).widget(
            (context, department) =>
                department.title.widget(builder: (context, title) {
                  return Card(
                    // color: Theme.of(context).primaryColorDark,
                    child: ListTile(
                        title: Text(
                      title.text,
                      style: TextStyle(
                          // color: Theme.of(context).primaryColor
                          ),
                    )),
                  );
                })))
        .toList();
  }

// words
  List<DocumentReference> _words = <DocumentReference>[];
  List<DocumentReference> get words => _words;
  void addWord(DocumentReference documentReference) {
    if (documentReference != null && !_words.contains(documentReference)) {
      _words.add(documentReference);
      notifyListeners();
    }
  }

  void deleteWord(DocumentReference documentReference) {
    if (documentReference != null && _words.contains(documentReference)) {
      _words.removeWhere((document) => document == documentReference);
      notifyListeners();
    }
  }

  List<Widget> getWords(BuildContext context) {
    return words
        .map((word) => GetWord(reference: word).widget(
            (context, wordOb) => wordOb.title.widget(builder: (context, title) {
                  return Card(
                    // color: Theme.of(context).primaryColorDark,
                    child: ListTile(
                        title: Text(
                      title.text,
                      style: TextStyle(
                          // color: Theme.of(context).primaryColor
                          ),
                    )),
                  );
                })))
        .toList();
  }

// image
  ImageController _image = ImageController();
  ImageController get image => _image;
  set imageUrl(String urlValue) {
    if (urlValue.isNotEmpty) {
      _image.urlController.text = urlValue;
      imageType = "url";
    }
  }

  set imageFile(File fileValue) {
    if (fileValue != null) {
      _image.file = fileValue;
      imageType = "file";
    }
  }

  Future getImageFromPhone() async {
    var imageResult = await API_Image.pickImageFromPhone();
    if (imageResult != null) {
      imageFile = imageResult;
      notifyListeners();
    }
  }

  Future getImageFromCamera() async {
    var imageResult = await API_Image.pickImageFromCamera();
    if (imageResult != null) {
      imageFile = imageResult;
      notifyListeners();
    }
  }

  set imageType(String typeString) {
    if (typeString.isNotEmpty) {
      _image.type = typeString;
      notifyListeners();
    }
  }

  Widget get getImageWidget {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: RoundedCard(
          borderRadius: BorderRadius.circular(15),
          child: (image.type == "url")
              ? CacheImageWidget(
                  imageUrl: image.urlController.value.text,
                  assetImageTag: PlaceHolderImages.emptyImage,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                )
              : (image.type == "file")
                  ? Image.file(
                      image.file,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      PlaceHolderImages.emptyImage,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }

// video
  Map<String, String> videoInfo = {};

// Audio
  AudioController _audio = AudioController();
  AudioController get audio => _audio;
  set audioUrl(String urlValue) {
    if (urlValue.isNotEmpty) {
      _audio.url = urlValue;
      audioType = "url";
    }
  }

  set audioFile(File fileValue) {
    if (fileValue != null) {
      _audio.file = fileValue;
      audioType = "file";
    }
  }

  set audioType(String typeString) {
    if (typeString.isNotEmpty) {
      _audio.type = typeString;
      notifyListeners();
    }
  }

  Future getAudio() async {
    var audioResult = await FilePicker.getFile(type: FileType.audio);
    // var audioResult = await FilePicker.getFile(type: FileType.audio);
    if (audioResult != null) {
      audioFile = audioResult;
      notifyListeners();
    }
  }

// Book
  BookController _book = BookController();
  BookController get book => _book;
  set bookType(String typeString) {
    if (typeString.isNotEmpty) {
      _book.type = typeString;
      notifyListeners();
    }
  }

  set bookUrl(String urlValue) {
    if (urlValue.isNotEmpty) {
      _book.url = urlValue;
      bookType = "url";
    }
  }

  set bookFile(File fileValue) {
    if (fileValue != null) {
      _book.file = fileValue;
      bookType = "file";
    }
  }

  Future getBook() async {
    var bookResult = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['pdf']);
    if (bookResult != null) {
      bookFile = bookResult;
      notifyListeners();
    }
  }

// video
  VideoController _video = VideoController();
  VideoController get video => _video;
  set videoUrl(String urlValue) {
    if (urlValue.isNotEmpty) {
      _video.url = urlValue;
      _video.type = "url";
      notifyListeners();
    }
  }

  set videoFile(File fileValue) {
    if (fileValue != null) {
      _video.file = fileValue;
      _video.type = "file";
      notifyListeners();
    }
  }

  Future getVideo() async {
    var videoResult = await FilePicker.getFile(type: FileType.video);
    if (videoResult != null) {
      videoFile = videoResult;
      notifyListeners();
    }
  }

// upload ....................................................................................................................

  int loadingLevel = 0;
  Future<void> uploadItem(BuildContext context) async {
    try {
      if (titles.isNotEmpty &&
          !titles
              .any((title) => title.controller.value.text.trim().length < 10)) {
        loadingLevel = 1;
        notifyListeners();
        var itemReference =
            await GetAuthentication().currentUser.itemsReference.add(
          {
            "createAt": Timestamp.now(),
            "type": type,
            "references": [
              ...departments,
              ...words,
              GetAuthentication().currentUserReference,
            ],
            "defaultLanguageCode": S.of(context).languageCode,
          },
        );
        loadingLevel = 2;
        notifyListeners();
        for (var title in titles) {
          await itemReference
              .collection("Title")
              .doc(title.language.languageCode)
              .set({"text": title.controller.value.text},
                  SetOptions(merge: true));
        }
        loadingLevel = 3;
        notifyListeners();
        for (var description in descriptions.where((description) =>
            description.controller.value.text.trim().length > 10)) {
          await itemReference
              .collection("Description")
              .doc(description.language.languageCode)
              .set({"text": description.controller.value.text},
                  SetOptions(merge: true));
        }

        if (type == "Book") {
          loadingLevel = 51;
          notifyListeners();
          if (book.type == "file") {
            var bookUrl = await UpLoadFile.file(
                context: context,
                file: book.file,
                path:
                    itemReference.path + "/book/" + S.of(context).languageCode);
            String _url = await bookUrl.getDownloadURL();
            await itemReference
                .collection("Book")
                .doc(S.of(context).languageCode)
                .set(
              {"url": _url},
              SetOptions(merge: true),
            );
          } else if (book.type == "url") {
            await itemReference
                .collection("Book")
                .doc(S.of(context).languageCode)
                .set(
              {"url": book.urlController.value.text.trim()},
              SetOptions(merge: true),
            );
          }
        } else if (type == "Video") {
          loadingLevel = 52;
          notifyListeners();
          if (video.type == "file") {
            var videoUrl = await UpLoadFile.file(
                context: context,
                file: video.file,
                path: itemReference.path +
                    "/video/" +
                    S.of(context).languageCode);
            String _url = await videoUrl.getDownloadURL();
            await itemReference.collection("Video").doc("video").set(
              {"url": _url},
              SetOptions(merge: true),
            );
          } else if (video.type == "url") {
            await itemReference.collection("Video").doc("video").set(
              {"url": video.urlController.value.text},
              SetOptions(merge: true),
            );
          }
        } else if (type == "Audio") {
          loadingLevel = 53;
          notifyListeners();
          if (audio.type == "file") {
            var audioUrl = await UpLoadFile.file(
                context: context,
                file: audio.file,
                path: itemReference.path +
                    "/audio/" +
                    S.of(context).languageCode);
            String _url = await audioUrl.getDownloadURL();
            await itemReference.collection("Video").doc("video").set(
              {"url": _url},
              SetOptions(merge: true),
            );
          } else if (audio.type == "url") {
            await itemReference
                .collection("Voice")
                .doc(S.of(context).languageCode)
                .set(
              {"url": audio.urlController.value.text},
              SetOptions(merge: true),
            );
          }
        }

        loadingLevel = 4;
        notifyListeners();
        if (image.type == "file") {
          var imageUrl = await UpLoadFile.file(
              context: context,
              file: image.file,
              path: itemReference.path + "/image");
          String _url = await imageUrl.getDownloadURL();
          await itemReference.collection("Image").doc("image").set(
            {"url": _url},
            SetOptions(merge: true),
          );
        } else if (image.type == "url") {
          await itemReference.collection("Image").doc("image").set(
            {"url": image.urlController.value.text},
            SetOptions(merge: true),
          );
        }

        Navigator.of(context).pop();
      }
    } catch (e) {
      loadingLevel = 0;
      notifyListeners();
      return null;
    }
  }
}
