//Example of Repo
//You might not use it
import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/result_quiz/data/network/result_quiz_network.dart';

mixin ResultQuizRepo {
  final _myNetwork = ResultQuizNetwork();

//   // Every function should have repo as prefix

  Future<ResponseDefaultModel> repoPostPoin({required int nis, required int poin, required String poinType, required String groupID}) async {
    try {
      final res = await _myNetwork.postPoin(nis: nis, poin: poin, poinType: poinType, groupID: groupID);

      return res;
    } catch (e) {
      rethrow;
    }
  }
  

  Future<SiswaModel> repoGetSiswa({required int nis}) async {
    try {
      final res = await _myNetwork.getSiswa(nis: nis);
      return SiswaModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
