import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class ResultQuizNetwork {
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

  Future<ResponseDefaultModel> postPoin({required int nis, required int poin, required String poinType, required String groupID}) async {
    try {
      final data = {'nis': nis, 'poin_quiz': poin, 'poin_type': poinType, 'group_id': groupID};
      final res = await AppNetworkClient.post(path: '/student/collect-poin', jsonMap: data);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
