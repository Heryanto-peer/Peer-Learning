import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/repo/challenge_quiz_repo.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_mobile_user/module/quiz/prepare_quiz/data/model/quiz_model.dart';
import 'package:get/get.dart';

class ChallengeQuizController extends GetxController with ChallengeQuizRepo {
  double countdown = 1.0;
  Color colorCountdown = AppColors.base.secondary;
  Timer? timer;
  int totalQuestion = 10;
  int currentQuestion = 1;
  int totalPoin = 0;
  String? lockedAnswer;
  late QuizTypeEnum typeQuiz;
  String keyAnswer = 'the ansewer';
  String tagAnswer = 'the ansewer';
  String? claimPoin;
  String? tips;
  Map<String, dynamic> listChoice = {'A': 'the ansewer', 'B': 'asdasd', 'C': 'asdasd', 'D': 'asdasd'};
  List<QuizModel> listQuiz = [];
  MateriModel? currentMateri;
  AudioPlayer audioPlayer = AudioPlayer();

  set setLockedAnswer(String? key) {
    lockedAnswer = key;
    update();
  }

  eventChoice() async {
    final key = lockedAnswer;
    if (timer != null) {
      timer!.cancel();
    }
    int poin = 0;
    currentQuestion++;
    final bool isCorrect = listChoice[key] == keyAnswer;
    poin = isCorrect
        ? 10
        : key == null
            ? 0
            : poin = 5;

    final remaining = 90 - (countdown * 90);
    int award = 1;
    if (poin > 5) {
      award = remaining <= 45
          ? 3
          : remaining > 45 && remaining <= 80
              ? 2
              : 1;
    }
    if (isCorrect) {
      await audioPlayer.play(AssetSource('sound/success.mp3'), volume: 1);
    } else if (poin > 0) {
      await audioPlayer.play(AssetSource('sound/failled.mp3'), volume: 1);
    }

    totalPoin = totalPoin + (poin * award);
    claimPoin = (poin * award).toString();
    update();

    await Future.delayed(const Duration(seconds: 4), () {
      claimPoin = null;
    });

    if (currentQuestion > totalQuestion) {
      _onFinished();
      return;
    }

    onResetVariable();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    final args = Get.arguments;
    typeQuiz = args['type'] as QuizTypeEnum;
    listQuiz = args['quiz'] as List<QuizModel>;
    currentMateri = args['materi'] as MateriModel?;
    totalQuestion = listQuiz.length;
    update();
    startTimer();
    super.onInit();
  }

  onResetVariable() {
    lockedAnswer = null;
    if (timer != null) {
      timer!.cancel();
      countdown = 1.0;
      colorCountdown = AppColors.base.secondary;
    }
    update();
  }

  startTimer() {
    if (timer != null) {
      onResetVariable();
    }

    _analyzeQuiz();
    double count = 90;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count < 0) {
        timer.cancel();
        debugPrint('finish');
        return;
      }
      countdown = count / 90;
      count = count - 1;
      debugPrint(countdown.toString());

      if (count < 10) {
        colorCountdown = AppColors.base.red;
      } else if (count < 45) {
        colorCountdown = AppColors.base.orange;
      } else {
        colorCountdown = AppColors.base.secondary;
      }
      update();
    });
  }

  _analyzeQuiz() async {
    final quiz = listQuiz[currentQuestion - 1];
    keyAnswer = quiz.answer ?? '';
    final List<String> opt = [quiz.option1 ?? '', quiz.option2 ?? '', quiz.option3 ?? '', quiz.option4 ?? ''];
    listChoice = {
      'A': quiz.option1 ?? '',
      'B': quiz.option2 ?? '',
      'C': quiz.option3 ?? '',
      'D': quiz.option4 ?? '',
    };

    final int replace = Random().nextInt(4);
    opt.shuffle();
    opt[replace] = keyAnswer;
    tagAnswer = replace == 0
        ? 'A'
        : replace == 1
            ? 'B'
            : replace == 2
                ? 'C'
                : 'D';
    listChoice = {'A': opt[0], 'B': opt[1], 'C': opt[2], 'D': opt[3]};
    tips = quiz.tips;
    update();
  }

  _onFinished() async {
    Get.offAndToNamed(RouteConstant.resultQuiz, arguments: {'type': typeQuiz, 'poin': totalPoin, 'materi': currentMateri});
  }
}
