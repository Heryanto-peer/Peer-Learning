//Example of Repo
//You might not use it
import 'package:flutter/widgets.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/model/materi_model.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/network/materi_network.dart';

mixin MateriRepo {
  final _myNetwork = MateriNetwork();

  Future<ResponseDefaultModel> repoAddSubject({required Map<String, dynamic> data}) async {
    try {
      return await _myNetwork.addSubject(data: data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoDeleteSubject({required String subjectID}) async {
    try {
      return await _myNetwork.deleteSubject(subjectID: subjectID);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<MateriModel>> repoGetAllMateri() async {
    try {
      final res = await _myNetwork.getAllMateri();
      if (res.status == 200) {
        return List<MateriModel>.from(res.data.map((x) => MateriModel.fromJson(x)));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}
