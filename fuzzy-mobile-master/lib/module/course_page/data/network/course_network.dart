import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';

class CourseNetwork {
  Future<ResponseDefaultModel> getCourse() async {
    try {
      final classID = (await AppStore.instance.siswa)?.datumClass?.classId;
      final res = await AppNetworkClient.get(path: '/course?class_id=$classID');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
