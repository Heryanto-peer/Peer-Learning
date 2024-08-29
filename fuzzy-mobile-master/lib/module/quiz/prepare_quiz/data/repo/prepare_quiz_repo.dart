import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/prepare_quiz/data/network/prepare_quiz_newtork.dart';

mixin PrepareQuizRepo {
  final _myNetwork = PrepareQuizNetwork();
  Future<ResponseDefaultModel> repoGetAllQuizByType({required String? typeQuiz}) async => await _myNetwork.getAllQuizByType(typeQuiz: typeQuiz);

  Future<MateriModel> repoGetSubjectDetail({required String subjectId}) async {
    try {
      final res = await _myNetwork.getSubjectDetail(subjectId: subjectId);
      return MateriModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoQuizBySubject({
    required String subjectID,
    required int page,
    int? limit,
    String? typeQuiz,
  }) async {
    try {
      return await _myNetwork.getQuizBySubject(subjectID: subjectID, page: page, limit: limit, typeQuiz: typeQuiz);
    } catch (e) {
      rethrow;
    }
  }
}
