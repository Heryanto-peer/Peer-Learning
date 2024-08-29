//Example of Repo
//You might not use it
import 'package:fuzzy_web_admin/module/login/data/model/teacher_model.dart';
import 'package:fuzzy_web_admin/module/login/data/network/login_network.dart';

mixin LoginRepo {
  final _myNetwork = LoginNetwork();

  Future<TeacherModel> repoLogin({required Map<String, dynamic> data}) async {
    try {
      final res = await _myNetwork.postLogin(data: data);
      if (res.status != 200) {
        throw res.message ?? 'Something went wrong';
      }
      return TeacherModel.fromMap(res.data);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
