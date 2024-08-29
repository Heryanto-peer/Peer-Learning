import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class ProfileNetwork {
  Future<ResponseDefaultModel> getGroupsMembers({required String groupID}) async {
    try {
      final res = await AppNetworkClient.get(path: '/group/members?group_id=$groupID');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
