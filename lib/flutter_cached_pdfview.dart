import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:uc_pdfview/uc_pdfview.dart';

import 'load_file_on_ram.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class FlutterCachedPdfview extends StatefulWidget {
  final String title;
  const FlutterCachedPdfview({Key? key, required this.title}) : super(key: key);

  @override
  State<FlutterCachedPdfview> createState() => _FlutterCachedPdfviewState();
}

class _FlutterCachedPdfviewState extends State<FlutterCachedPdfview>
    with WidgetsBindingObserver {
  File? file;
  var pdfViewerKey = UniqueKey();
  PDFViewController? pdfViewController;
  int? currentPage;

  void loadPdf() async {
    // pdfFlePath = await downloadAndSavePdf();
    File file = await LoadFileOnRam.createFileFromAssets('assets/bereshit.pdf');
    setState(() {
      this.file = file;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      var currentPage = await pdfViewController?.getCurrentPage();
      print('currentPage $currentPage');
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          pdfViewerKey = UniqueKey();
        });

        Future.delayed(const Duration(milliseconds: 300), () {
          if (currentPage != null) {
            pdfViewController?.setPage(currentPage);
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => print('tap'),
        child:
            // file != null
            //     ?
            PDF(
          // filePath: file!.path,
          pageSnap: false,
          autoSpacing: false,
          fitEachPage: false,
          pageFling: false,
          onError: (error) {
            print('error $error');
          },
          onPageChanged: (int? page, int? totalPages) {
            print('current page $page of $totalPages');
          },
          onViewCreated: (PDFViewController controller) {
            pdfViewController = controller;
          },
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer())
          },
        ).fromAsset('assets/bereshit.pdf', key: pdfViewerKey,
                errorWidget: (error) {
          print(error);
          return Center(child: Text('error $error'));
        }),
        // : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
