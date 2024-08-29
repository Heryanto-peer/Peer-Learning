import 'package:fuzzy_mobile_user/common/model/assesment_model.dart';
import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/module/assesment/data/network/assesment_network.dart';

mixin AssesmentRepo {
  final _myNetwork = AssesmentNetwork();

  Future<AssesmentModel> repoGetAssesment({required int nis}) async {
    try {
      final res = await _myNetwork.getMyAsessment(nis: nis);
      return AssesmentModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoPostAssesment({required String assesmentID, required List<Assesment> assesments}) async {
    try {
      final res = await _myNetwork.postSubmitAsessment(assesmentID: assesmentID, assesments: assesments);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
