//Example of Repo
//You might not use it
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/network/materi_network.dart';

mixin MateriPageRepo {
  final _myNetwork = MateriNetwork();
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
