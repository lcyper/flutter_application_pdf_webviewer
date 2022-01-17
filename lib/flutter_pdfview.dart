import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'load_file_on_ram.dart';

class FlutterPdfview extends StatefulWidget {
  final String title;
  const FlutterPdfview({Key? key, required this.title}) : super(key: key);

  @override
  _FlutterPdfviewState createState() => _FlutterPdfviewState();
}

class _FlutterPdfviewState extends State<FlutterPdfview> {
  File? file;

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
    // createFileOfPdfUrl().then((f) {
    //   setState(() {
    //     file = f;
    //   });
    // });
  }

  Future<File> createFileOfPdfUrl() async {
    const url = "http://www.pdf995.com/samples/pdf.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  // final _controller = PdfViewController();
  int currentPage = 0;
  late final PDFViewController pdfViewerController;

  @override
  Widget build(BuildContext context) {
    // pdfViewerController.goToPage(pageNumber: 37);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: FittedBox(child: Text(widget.title)),
        centerTitle: true,
      ),
      body: file != null
          ? PDFView(
              fitEachPage: true,
              filePath: file!.path,
              enableSwipe: true,
              // swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
              onRender: (_pages) {
                print('total pages: $_pages');
              },
              onError: (error) {
                print(error.toString());
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                pdfViewerController = pdfViewController;
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
