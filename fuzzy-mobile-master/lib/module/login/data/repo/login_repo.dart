import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/module/login/data/network/login_network.dart';

mixin LoginRepo {
  final _myNetwork = LoginNetwork();

  Future<SiswaModel> repoLogin({required Map<String, dynamic> data}) async {
    try {
      final res = await _myNetwork.postLogin(data: data);
      if (res.status != 200) {
        throw res.message ?? 'Something went wrong';
      }
      return SiswaModel.fromJson(res.data);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
