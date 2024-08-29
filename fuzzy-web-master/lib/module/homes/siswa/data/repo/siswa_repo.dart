import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/network/siswa_network.dart';

mixin SiswaRepo {
  final _myNetwork = SiswaNetwork();

  Future<ResponseDefaultModel> repoAddStudent({required Map<String, dynamic> data}) async {
    return await _myNetwork.addStudent(data: data);
  }

  Future<bool> repoDeleteStudent({required int nis, required String password}) async {
    try {
      final res = await _myNetwork.deleteStudent(nis: nis, password: password);
      if (res.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<ResponseDefaultModel> repoGetAllStudent({int? page, int? limit, String? search, String? tag}) async {
    return await _myNetwork.getAllStudent(page: page, limit: limit, search: search, tag: tag);
  }

  Future<String> repoUploadImageProfile({required Uint8List images, required int nis}) async {
    try {
      return await _myNetwork.uploadImageProfile(images: images, nis: nis);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
