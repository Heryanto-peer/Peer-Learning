import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/common/widget/app_snackbar.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_mobile_user/module/quiz/result_quiz/data/repo/result_quiz_repo.dart';
import 'package:fuzzy_mobile_user/module/quiz/result_quiz/data/utils/poin_type_enum.dart';
import 'package:get/get.dart';

class ResultQuizController extends GetxController with ResultQuizRepo {
  SiswaModel? siswa;
  int totalPoin = 0;
  QuizTypeEnum? typeQuiz;
  MateriModel? currentMateri;

  void eventExit() {
    Get.offAllNamed(RouteConstant.home);
    // _eventCollectPoin();
  }

  void eventOpenMateri() async {
    // _eventCollectPoin();

    if (currentMateri?.materisModel?.isNotEmpty == true) {
      final url = 'http://${currentMateri?.materisModel?.first.pathMateri}';
      // if (await canLaunchUrlString(url)) {
      //   debugPrint('Launching $url');
      //   await launchUrlString(
      //     url,
      //     mode: LaunchMode.inAppWebView,
      //   );
      // }

      await Get.toNamed(RouteConstant.materiView, arguments: url);
      debugPrint('materi ${currentMateri?.materisModel?.first.pathMateri}');
      Get.offAllNamed(RouteConstant.assesment, arguments: {'materi': currentMateri});
    }
  }

  @override
  void onInit() async {
    final args = Get.arguments;
    typeQuiz = args['type'] as QuizTypeEnum;
    totalPoin = args['poin'] as int;
    currentMateri = args['materi'] as MateriModel?;
    siswa = await AppStore.instance.siswa;
    update();

    if (typeQuiz == QuizTypeEnum.practiceQuiz) {
      Get.offAllNamed(RouteConstant.home);
    } else {
      await _eventCollectPoin();
    }

    super.onInit();
  }

  _eventCollectPoin() async {
    try {
      if (siswa == null) {
        return;
      }
      final res = await repoPostPoin(
        nis: siswa?.nis ?? 0,
        poin: totalPoin,
        poinType: ConvertPoinType.convertQuizTypeToPoinType(typeQuiz!),
        groupID: siswa?.group?.groupId ?? '',
      );

      if (res.status == 200) {
        AppSnackbar.succes(succes: 'Poin Telah Ditambahkan');
      }

      final user = await repoGetSiswa(nis: siswa?.nis ?? 0);
      await AppStore.instance.setSiswa(user);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
