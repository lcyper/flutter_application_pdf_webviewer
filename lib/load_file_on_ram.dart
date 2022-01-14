import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class LoadFileOnRam {
  static Future<File> createFileFromUrl(String url) async {
    Completer<File> completer = Completer();
    // print("Start download file from internet!");
    try {
      final String filename = url.substring(url.lastIndexOf("/") + 1);
      HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
      HttpClientResponse response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      Directory dir = await getApplicationDocumentsDirectory();
      // print("File downloaded");
      // print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }

  static Future<File> createFileFromAssets(String filePath) async {
    Completer<File> completer = Completer();
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String filename =  fileName(filePath);
      File file = File("${dir.path}/$filename");
      ByteData  data = await rootBundle.load(filePath);
      Uint8List bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }
    return completer.future;
  }
  static String fileName(String filePath){
    return filePath.substring(filePath.lastIndexOf("/") + 1);
  }
}
