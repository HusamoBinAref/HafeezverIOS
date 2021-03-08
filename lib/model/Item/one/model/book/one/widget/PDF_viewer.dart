import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  PDFViewerScreen({Key key, this.url}) : super(key: key);
  final String url;
  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  Future<File> get file {
    return DefaultCacheManager().getSingleFile(
      widget.url,
    );
  }

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();

    super.initState();
  }

  PdfViewerController _pdfViewerController;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<File>(
        future: file,
        builder: (context, fileSnap) {
          if (fileSnap.hasData) {
            var fileData = fileSnap.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                actions: [
                  IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        _pdfViewerController.previousPage();
                        setState(() {});
                      }),
                  IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        _pdfViewerController.nextPage();
                        setState(() {});
                      }),
                  IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        _pdfViewerKey.currentState?.openBookmarkView();
                      }),
                ],
                title: Text(_pdfViewerController.pageNumber.toString() +
                    "/" +
                    _pdfViewerController.pageCount.toString()),
              ),
              body: SfPdfViewer.file(
                fileData,
                controller: _pdfViewerController,
                key: _pdfViewerKey,
                onDocumentLoaded: (_) {
                  setState(() {});
                },
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
