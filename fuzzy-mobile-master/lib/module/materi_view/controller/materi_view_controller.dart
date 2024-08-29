import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class MateriViewController extends GetxController {
  String urlPDFPath = '';
  bool loaded = true;
  bool exists = false;
  String path = '';

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      final data = await http.get(Uri.parse(url));
      final bytes = data.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      final File file = File('${dir.path}/$fileName.pdf');
      debugPrint(dir.path);
      final File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception('Error opening url file');
    }
  }

  @override
  void onInit() async {
    await requestPersmission();
    path = Get.arguments as String;
    await getFileFromUrl(path).then((value) {
      urlPDFPath = value.path;
      loaded = false;
      exists = true;
      update();
    });
    super.onInit();
  }

  requestPersmission() async {
    if (await permission.Permission.storage.request().isGranted == false) {
      await permission.Permission.storage.request();
    }
  }
}
