import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_platform_view/pdf_platform_view.dart';

import 'load_file_on_ram.dart';

class PdfPlataformView extends StatefulWidget {
  final String title;
  const PdfPlataformView({Key? key, required this.title}) : super(key: key);

  @override
  _PdfPlataformViewState createState() => _PdfPlataformViewState();
}

class _PdfPlataformViewState extends State<PdfPlataformView> {
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

  final _controller = PdfViewController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    print('Number of pages: ${_controller.numberOfPages}');
    _controller.pagePosition.addListener(() {
      if (_controller.pagePosition.value.page != currentPage) {
        currentPage = _controller.pagePosition.value.page;
        print(currentPage);
      }
    });
    // _controller.setPagePosition(PagePosition(
    //     currentPosition: currentPosition,
    //     zoom: zoom,
    //     page: page,
    //     progress: progress));
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: file != null
          ? PdfView(
              file: file,
              controller: _controller,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
