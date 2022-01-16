import 'package:flutter/material.dart';
import 'package:flutter_application_pdf_webviewer/pdf_plataform_view.dart';

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
              // home: const PdfViewerPlugin(),
              // home: PdfPlataformView(),
              // home: const WebViewExample(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PdfViewerPlugin(title:'PdfViewerPlugin'),
                      ));
                },
                child: const Text('PdfViewerPlugin'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PdfPlataformView(title:'PdfPlataformView'),
                      ));
                },
                child: const Text('PdfPlataformView'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WebViewExample(title:'WebViewExample'),
                      ));
                },
                child: const Text('WebViewExample'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
