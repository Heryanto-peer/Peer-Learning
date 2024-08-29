import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_mobile_user/module/quiz/prepare_quiz/data/model/quiz_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/prepare_quiz/data/repo/prepare_quiz_repo.dart';
import 'package:get/get.dart';

class PrepareQuizController extends GetxController with PrepareQuizRepo {
  String? countdown;
  List<QuizModel> listQuiz = [];
  QuizTypeEnum? typeQuiz;
  MateriModel? currentMateri;

  eventStartQuiz() {
    int count = 0;
    if (countdown != null) {
      countdown = null;
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (t) {
      count = count + 1;

      if (count == 5) {
        countdown = null;
        update();
        t.cancel();
        Get.offAndToNamed(RouteConstant.challengeQuiz, arguments: {'type': typeQuiz, 'quiz': listQuiz, 'materi': currentMateri});
      } else if (count > 3 && count < 5) {
        countdown = 'Start';
        update();
      } else {
        countdown = (4 - count).toString();
        update();
      }
    });
  }

  findCurrentQuiz(String subjectId) async {
    try {
      final res = await repoGetSubjectDetail(subjectId: subjectId);
      currentMateri = res;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getQuiz() async {
    try {
      final res = await repoGetAllQuizByType(typeQuiz: ConvertQuizType.convertQuizForDB(typeQuiz));
      if (res.status == 200) {
        listQuiz = List<QuizModel>.from(res.data.map((x) => QuizModel.fromJson(x)));
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getQuizById() async {
    try {
      final String type = ConvertQuizType.convertQuizForDB(typeQuiz);

      final res = await repoQuizBySubject(subjectID: currentMateri!.subjectId!, page: 1, typeQuiz: type);
      if (res.status == 200) {
        listQuiz = List<QuizModel>.from(res.data.map((x) => QuizModel.fromJson(x)));
        update();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() async {
    final args = Get.arguments;
    typeQuiz = args['type'] as QuizTypeEnum;
    update();

    if (typeQuiz != QuizTypeEnum.dailyQuiZ) {
      await findCurrentQuiz(args['subjectId'] as String);
      await getQuizById();
    } else {
      await getQuiz();
    }
    super.onInit();
  }
}
