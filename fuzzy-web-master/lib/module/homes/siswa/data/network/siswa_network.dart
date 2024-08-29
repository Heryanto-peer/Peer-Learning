import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/core/network/app_network.dart';

class SiswaNetwork {
  Future<ResponseDefaultModel> addStudent({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/student/register', jsonMap: data);
      return ResponseDefaultModel.fromRawJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> deleteStudent({required int nis, required String password}) async {
    try {
      final res = await AppNetworkClient.delete(path: '/student/remove', form: FormData.fromMap({'nis': nis, 'password': password}));
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getAllStudent({int? page, int? limit, String? search, String? tag}) async {
    try {
      final res = await AppNetworkClient.get(path: '/student/all?page=$page&limit=$limit&search=$search&tag=$tag');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> updateStudent({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/student/update', jsonMap: data);
      return ResponseDefaultModel.fromRawJson(res.data);
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
}
