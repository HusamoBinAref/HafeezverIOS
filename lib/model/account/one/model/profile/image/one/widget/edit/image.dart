import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hafeez/classes/tools/pick_image.dart';
import 'package:hafeez/classes/tools/upload.dart';
import 'package:hafeez/classes/tools/placeholder.dart';

import 'package:hafeez/model/account/one/model/profile/model/image/model/image.dart';

import 'package:hafeez/widget/cache_image_widgets.dart';
import 'package:hafeez/widget/containers.dart';

class ModifyImageWidget extends StatefulWidget {
  const ModifyImageWidget({
    Key key,
    this.itemImage,
  }) : super(key: key);
  final ImageProfile itemImage;
  @override
  _ModifyImageWidgetState createState() => _ModifyImageWidgetState();
}

class _ModifyImageWidgetState extends State<ModifyImageWidget> {
  bool isLoading = false;
  File image;
  double value = 0;

  Future getImageFromPhone() async {
    var imageResult = await API_Image.pickImageFromPhone();
    if (imageResult != null) {
      setState(() {
        image = imageResult;
      });
    } 
  }

  Future getImageFromCamera() async {
    var imageResult = await API_Image.pickImageFromCamera();
    if (imageResult != null) {
      setState(() {
        image = imageResult;
      });
    }
  }

  Widget getImage(BuildContext context) {
    if (image != null)
      return Image.file(image);
    else
      return CacheImageWidget(
        imageUrl: widget.itemImage.url,
        assetImageTag: PlaceHolderImages.postImage,
      );
  }

  Future imageUpLoading(
    BuildContext context, {
    Function(double value) refreshProgress,
  }) async {
    setState(() {
      isLoading = true;
    });

    var reference = await UpLoadFile.file(
        context: context,
        file: image,
        path: widget.itemImage.reference.path + "image",
        refreshProgress: (progressValue) {
          setState(() {
            value = progressValue;
          });
        });

    if (reference != null) {
      String photoUrl = await reference.getDownloadURL();
      widget.itemImage.modify.setData(context, photoUrl).whenComplete(() {
        setState(() {
          isLoading = false;
          value = 0;
        });
        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text("Files Uploaded Successfully :)")),
        ).then((value) => Navigator.pop(context));
      });
    } else
      setState(() {
        isLoading = false;
        value = 0;
      });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            appBar: AppBar(),
            body: Center(child: Containers.waitting(context)),
          )
        : Scaffold(
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (image != null) imageUpLoading(context);
              },
              child: Icon(Icons.cloud_upload),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.all(10),
                    child: getImage(context),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: OutlineButton(
                        padding: const EdgeInsets.all(0),
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add_photo_alternate),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text('المعرض'),
                                ),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          getImageFromPhone();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: OutlineButton(
                        padding: const EdgeInsets.all(0),
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.add_a_photo),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text('الكاميرا'),
                                ),
                              )
                            ],
                          ),
                        ),
                        onPressed: () {
                          getImageFromCamera();
                        }),
                  )
                ],
              ),
            ),
          );
  }
}
