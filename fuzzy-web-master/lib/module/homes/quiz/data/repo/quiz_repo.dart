//Example of Repo
//You might not use it
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/network/quiz_network.dart';

mixin QuizRepo {
  final _myNetwork = QuizNetwork();

  Future<ResponseDefaultModel> repoAddQuiz({required Map<String, dynamic> data}) async {
    try {
      return await _myNetwork.addQuiz(data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseDefaultModel> repoDeleteQuiz({required String questionID}) async {
    try {
      return await _myNetwork.deleteQuiz(questionID: questionID);
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
