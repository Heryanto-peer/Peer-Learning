import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class HomepageNetwork {
  Future<ResponseDefaultModel> getGroupsByClassId({required String classId}) async {
    try {
      final res = await AppNetworkClient.get(path: '/group/all?class_id=$classId');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getMyGroup({required String groupID}) async {
    try {
      final res = await AppNetworkClient.get(
        path: '/group/members?group_id=$groupID',
      );
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getSiswa({required int nis}) async {
    try {
      final res = await AppNetworkClient.get(
        path: '/student/detail?nis=$nis',
      );
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
