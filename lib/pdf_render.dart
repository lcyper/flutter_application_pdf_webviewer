import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfRender extends StatefulWidget {
  final String title;
  const PdfRender({Key? key, required this.title}) : super(key: key);

  @override
  _PdfRenderState createState() => _PdfRenderState();
}

class _PdfRenderState extends State<PdfRender> {
  List filesPaths = [
    'assets/bereshit.pdf',
    'assets/bereshit-02.pdf',
  ];
  bool isFirst = true;
  int initialPageNumber = 1;
  var pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    pdfViewerController.addListener(() {
      if (initialPageNumber != pdfViewerController.currentPageNumber) {
        initialPageNumber = pdfViewerController.currentPageNumber;
        print('current Page Number: ${pdfViewerController.currentPageNumber}');
      }
    });
  }

  @override
  void dispose() {
    pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // pdfViewerController.goToPage(pageNumber: 37);

    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: FittedBox(child: Text(widget.title)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          isFirst = !isFirst;
        }),
        child: const Icon(Icons.repeat_rounded),
      ),
      body:
          // PdfDocumentLoader.openAsset(
          //   filesPaths[isFirst ? 0 : 1],
          //   // key: Key('assets/$_file'),
          //   documentBuilder: (context, pdf, pageCount) => LayoutBuilder(
          //     builder: (context, constraints) => InteractiveViewer(
          //       maxScale: 5,
          //       child: ListView.builder(
          //         scrollDirection: Axis.vertical,
          //         itemCount: pageCount,
          //         itemBuilder: (context, index) => Container(
          //           // margin: EdgeInsets.all(5),
          //           padding: const EdgeInsets.only(bottom: 10),
          //           child: PdfPageView(
          //             pdfDocument: pdf,
          //             pageNumber: index + 1,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          //   onError: (error) => print(error.toString()),
          // ),
          PdfViewer.openAsset(
        filesPaths[isFirst ? 0 : 1],
        viewerController: pdfViewerController,
        params: PdfViewerParams(
          pageNumber: initialPageNumber,
          maxScale: 5,
          // minScale: 1.0,
          padding: 5.0,
        ),
      ),
    );
  }
}
