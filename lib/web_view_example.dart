import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'load_file_on_ram.dart';

class WebViewExample extends StatefulWidget {
  final String title;
  const WebViewExample({Key? key, required this.title}) : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(widget.title)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'about:blank',
          // initialUrl: 'file://assets/bereshit.pdf',
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
            _loadHtmlFromAssets();
          },
        ),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    // 'file://assets/bereshit.pdf'
    File file = await LoadFileOnRam.createFileFromAssets('assets/bereshit.pdf');
    var fileText = await rootBundle.load('assets/bereshit.pdf');
    // await rootBundle.loadString('assets/help.html'); //bereshit.pdf
    _controller.loadUrl('file://${file.path}');
    // _controller.loadUrl(
    //   // fileText
    //   Uri.dataFromString(fileText,
    //           mimeType: 'text/html', //'application/pdf',
    //           encoding: Encoding.getByName('utf-8'))
    //       .toString(),
    // );
  }
}
