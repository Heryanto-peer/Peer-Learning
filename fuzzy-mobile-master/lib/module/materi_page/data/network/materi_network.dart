import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class MateriNetwork {
  Future<ResponseDefaultModel> getAllMateri() async {
    try {
      final res = await AppNetworkClient.get(path: '/subject/all');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
