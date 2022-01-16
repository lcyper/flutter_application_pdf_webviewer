import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

import 'load_file_on_ram.dart';

class PdfViewerPlugin extends StatefulWidget {
  final String title;
  const PdfViewerPlugin({Key? key, required this.title}) : super(key: key);

  @override
  _PdfViewerPluginState createState() => _PdfViewerPluginState();
}

class _PdfViewerPluginState extends State<PdfViewerPlugin> {
  final sampleUrl = 'http://www.africau.edu/images/default/sample.pdf';

  String? pdfFlePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/sample.pdf');
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(sampleUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    // pdfFlePath = await downloadAndSavePdf();
    File file = await LoadFileOnRam.createFileFromAssets('assets/bereshit.pdf');
    pdfFlePath = file.path;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            if (pdfFlePath != null)
              Expanded(
                // TODO: Cambiar configuracion en: (espacio entre hojas y color)
                // https://github.com/lubritto/pdf_viewer_plugin/issues/18#issuecomment-592581177
                // file://C:\flutter\.pub-cache\hosted\pub.dartlang.org\pdf_viewer_plugin-2.0.1\android\src\main\java\dev\britto\pdf_viewer_plugin\PdfViewer.java
                child: PdfView(
                  path: pdfFlePath!,
                ),
              )
            else
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
