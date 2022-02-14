import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'load_file_on_ram.dart';

class WebViewExample extends StatefulWidget {
  final String title;
  const WebViewExample({Key? key, required this.title}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  // late final WebViewController _controller;
  File? file;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    init();
  }

  void loadPdf() async {
    // pdfFlePath = await downloadAndSavePdf();
    File file = await LoadFileOnRam.createFileFromAssets('assets/bereshit.pdf');
    setState(() {
      this.file = file;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(widget.title)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: file != null
            ? InAppWebView(
                initialFile: file!.path,
                // initialUrlRequest: URLRequest(url: Uri.parse(file!.path)),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
        // child: WebView(
        //   initialUrl: 'about:blank',
        //   // initialUrl: 'file://assets/bereshit.pdf',
        //   onWebViewCreated: (WebViewController webViewController) {
        //     _controller = webViewController;
        //     _loadHtmlFromAssets();
        //   },
        // ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    // 'file://assets/bereshit.pdf'
    File file = await LoadFileOnRam.createFileFromAssets('assets/bereshit.pdf');
    var fileText = await rootBundle.load('assets/bereshit.pdf');
    // await rootBundle.loadString('assets/help.html'); //bereshit.pdf
    // _controller.loadUrl('file://${file.path}');
    // _controller.loadUrl(
    //   // fileText
    //   Uri.dataFromString(fileText,
    //           mimeType: 'text/html', //'application/pdf',
    //           encoding: Encoding.getByName('utf-8'))
    //       .toString(),
    // );
  }

  void init() async {
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
          AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController =
            AndroidServiceWorkerController.instance();

        serviceWorkerController.serviceWorkerClient =
            AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            print(request);
            return null;
          },
        );
      }
    }
    loadPdf();
  }
}
