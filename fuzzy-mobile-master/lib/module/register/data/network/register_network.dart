import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class RegisterNetwork {
  Future<ResponseDefaultModel> addStudent({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/student/register', jsonMap: data);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  /// upload image profile to firebase
  Future<String> uploadImageProfile({required Uint8List images, required int nis}) async {
    try {
      final Reference ref = FirebaseStorage.instance.ref().child('student/images_profile/$nis');
      final UploadTask uploadTask = ref.putData(images, SettableMetadata(contentType: 'image/jpeg'));
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      final String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }


  Future<ResponseDefaultModel> getAllKelas() async {
    try {
      final res = await AppNetworkClient.get(path: '/class/all');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
