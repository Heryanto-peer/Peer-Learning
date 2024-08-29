import 'package:dio/dio.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/core/network/app_network.dart';

class QuizNetwork {
  Future<ResponseDefaultModel> addQuiz({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.post(path: '/question/add', jsonMap: data);
      return ResponseDefaultModel.fromRawJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> deleteQuiz({required String questionID}) async {
    try {
      final res = await AppNetworkClient.delete(path: '/question/remove', form: FormData.fromMap({'question_id': questionID}));
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

  Future<ResponseDefaultModel> updateQuiz({required Map<String, dynamic> data}) async {
    try {
      final res = await AppNetworkClient.put(path: '/question/update', jsonMap: data);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> removeAllQuiz() async {
    try {
      final res = await AppNetworkClient.delete(path: '/question/removeall', form: FormData.fromMap({'key_pas': 'iam root'}));
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}
