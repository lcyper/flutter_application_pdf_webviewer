import 'package:flutter/material.dart';

// import 'flutter_pdfview.dart';
// import 'pdf_plataform_view.dart';
import 'flutter_cached_pdfview.dart';
import 'flutter_pdfview.dart';
import 'pdf_render.dart';
import 'syncfusion_flutter_pdfviewer.dart';
import 'web_view_example.dart';
import 'pdf_viewer_plugin.dart';

void main() {
  // flutter run --no-sound-null-safety
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('pdfs packages test'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => const PdfViewerPlugin(
              //             title: 'PdfViewerPlugin - sin controller'),
              //       ),
              //     );
              //   },
              //   child: const Text('PdfViewerPlugin'),
              // ),
              // ---------------
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => const PdfPlatformView(
              //               title:
              //                   'PdfPlatformView - controller, pero deprecated'),
              //         ));
              //   },
              //   child: const Text('PdfPlataformView'),
              // ),
              // --------------
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WebViewExample(
                          title: 'WebViewExample - android no funciona'),
                    ),
                  );
                },
                child: const Text('WebViewExample'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PdfRender(title: 'pdf_render'),
                    ),
                  );
                },
                child: const Text('PdfRender - me gusta'),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => const FlutterPdfview(
              //               title: 'flutter_pdfview - con controller'),
              //         ));
              //   },
              //   child: const Text('flutter_pdfview - orientation change error'),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SyncfusionFlutterPdfviewer(
                          title: 'syncfusion_flutter_pdfviewer'),
                    ),
                  );
                },
                child: const Text('syncfusion_flutter_pdfviewer'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const FlutterCachedPdfview(
                          title: 'flutter_cached_pdfview'),
                    ),
                  );
                },
                child: const Text('flutter_cached_pdfview'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
