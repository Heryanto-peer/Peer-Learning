import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/core/network/app_network.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';

class MateriNetwork {
  Future<ResponseDefaultModel> addMateri({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/subject/add/materi', form: FormData.fromMap(data));
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ResponseDefaultModel> addSubject({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/subject/add', jsonMap: data);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> deleteSubject({required String subjectID}) async {
    try {
      final res = await AppNetworkClient.delete(path: '/subject/remove', form: FormData.fromMap({'subject_id': subjectID}));
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

  Future<ResponseDefaultModel> removeMateri({required String subjectID, required String materiID}) async {
    try {
      final res = await AppNetworkClient.delete(path: '/subject/remove/materi', form: FormData.fromMap({'subject_id': subjectID, 'materi_id': materiID}));
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
