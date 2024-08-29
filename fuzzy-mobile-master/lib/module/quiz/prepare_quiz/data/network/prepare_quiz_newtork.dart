import 'package:fuzzy_mobile_user/common/model/response_default_model.dart';
import 'package:fuzzy_mobile_user/core/network/app_network.dart';

class PrepareQuizNetwork {
  Future<ResponseDefaultModel> getAllQuizByType({required String? typeQuiz}) async {
    try {
      final res = await AppNetworkClient.get(
        path: '/question/all?type_question=${typeQuiz ?? ''}',
      );
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getQuizBySubject({required String subjectID, required int page, int? limit, String? typeQuiz}) async {
    try {
      final res = await AppNetworkClient.get(path: '/question/subject?subject_id=$subjectID&page=$page${limit != null ? '&limit=$limit' : ''}${typeQuiz != null ? '&type_question=$typeQuiz' : ''}');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> getSubjectDetail({required String subjectId}) async {
    try {
      final res = await AppNetworkClient.get(path: '/subject/detail?subject_id=$subjectId');
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
