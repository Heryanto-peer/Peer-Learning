import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/group_model.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/module/homepage/data/network/homepage_network.dart';

mixin HomepageRepo {
  final _myNetwork = HomepageNetwork();

  Future<GroupModel> repoGetMyGroup({required String groupID}) async {
    try {
      final res = await _myNetwork.getMyGroup(groupID: groupID);
      return GroupModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<SiswaModel> repoGetSiswa({required int nis}) async {
    try {
      final res = await _myNetwork.getSiswa(nis: nis);
      return SiswaModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<List<GroupModel>> repoGetGroupByClassId({required String classId}) async {
    try {
      final res = await _myNetwork.getGroupsByClassId(classId: classId);
      return List<GroupModel>.from(res.data.map((x) => GroupModel.fromJson(x)));
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
