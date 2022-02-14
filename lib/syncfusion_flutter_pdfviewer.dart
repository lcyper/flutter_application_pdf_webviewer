import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SyncfusionFlutterPdfviewer extends StatelessWidget {
  final String title;
  const SyncfusionFlutterPdfviewer({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: FittedBox(child: Text(title)),
        centerTitle: true,
      ),
      body: SfPdfViewer.asset('assets/bereshit.pdf'),
    );
  }
}
