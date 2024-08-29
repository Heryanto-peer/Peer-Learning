import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/core/network/app_network.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';

class KelasNetwork {
  Future<ResponseDefaultModel> addCourse({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/course/add', form: FormData.fromMap(data));
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> addNewGroup(List<Map<String, dynamic>> data) async {
    try {
      final res = await AppNetworkClient.post(path: '/group/add', dataDynamic: data);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> addStudent({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/student/register', jsonMap: data);
      return ResponseDefaultModel.fromRawJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> addStudentIntoGroup({required List<String> listSiswa, required String groupID}) async {
    try {
      final res = await AppNetworkClient.post(path: '/student/add/group', dataDynamic: {'nis': listSiswa, 'group_id': groupID});
      return ResponseDefaultModel.fromJson(res.data);
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

  Future<ResponseDefaultModel> getAllKelas() async {
    final techer = await AppStore.instance.guru;
    try {
      final res = await AppNetworkClient.get(path: '/class/all?id=${techer?.nip}');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getAllMateri() async {
    final techer = await AppStore.instance.guru;

    try {
      final res = await AppNetworkClient.get(path: '/subject/all?id=${techer?.nip}');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getCourse({required String classID}) async {
    try {
      final res = await AppNetworkClient.get(path: '/course?class_id=$classID');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getDetailStudent({required String nis}) async {
    try {
      final res = await AppNetworkClient.get(path: '/student/detail?nis=$nis');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getGroupsByClassId({required String classId}) async {
    try {
      final res = await AppNetworkClient.get(path: '/group/all?class_id=$classId');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getSiswaKelas(String classId) async {
    try {
      final res = await AppNetworkClient.get(path: '/class/students?class_id=$classId');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> postAddKelas({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/class/add', jsonMap: data);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> postCountFuzzy({required String classId, required String time}) async {
    try {
      final res = await AppNetworkClient.get(path: '/student/worker-fuzzy?class_id=$classId&time=$time');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> postCountPoinGroup({required String classId}) async {
    try {
      final res = await AppNetworkClient.get(path: '/student/worker-group?class_id=$classId');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> removeCourse({required String classID}) async {
    try {
      final res = await AppNetworkClient.delete(path: '/course/remove?class_id=$classID');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> updateStudent({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.put(path: '/student/update', jsonMap: data);
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
}
