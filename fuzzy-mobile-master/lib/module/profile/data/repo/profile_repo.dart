import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/group_model.dart';
import 'package:fuzzy_mobile_user/module/profile/data/network/profile_network.dart';

mixin ProfileRepo {
  final _myNetwork = ProfileNetwork();

  Future<GroupModel> repoGetGroupByClassId({required String groupID}) async {
    try {
      final res = await _myNetwork.getGroupsMembers(groupID: groupID);
      return GroupModel.fromJson(res.data);
    } catch (e) {
      debugPrint(e.toString());
      return GroupModel();
    }
  }
}
