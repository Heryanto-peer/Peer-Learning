import 'package:fuzzy_mobile_user/common/model/assesment_model.dart';
import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class AssesmentNetwork {
  Future<ResponseDefaultModel> getMyAsessment({required int nis}) async {
    try {
      final res = await AppNetworkClient.get(
        path: '/assesment/get?nis=$nis',
      );
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> postSubmitAsessment({required String assesmentID, required List<Assesment> assesments}) async {
    try {
      final data = {'assesment_id': assesmentID, 'assesments': assesments};
      final res = await AppNetworkClient.post(
        path: '/assesment/update',
        jsonMap: data,
      );
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
