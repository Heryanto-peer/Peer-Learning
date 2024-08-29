import 'dart:typed_data';

import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/module/register/data/network/register_network.dart';

mixin RegisterRepo {
  final _myNetwork = RegisterNetwork();

  Future<ResponseDefaultModel> repoAddStudent({required Map<String, dynamic> data}) async => await _myNetwork.addStudent(data: data);

  Future<ResponseDefaultModel> repoGetAllKelas() async {
    try {
      return await _myNetwork.getAllKelas();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> repoUploadImageProfile({required Uint8List images, required int nis}) async => await _myNetwork.uploadImageProfile(images: images, nis: nis);
}
