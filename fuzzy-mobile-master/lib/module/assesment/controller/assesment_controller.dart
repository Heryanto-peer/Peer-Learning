import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/assesment_model.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/common/widget/app_snackbar.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/module/assesment/data/repo/assesment_repo.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:get/get.dart';

class AssesmentController extends GetxController with AssesmentRepo {
  SiswaModel? siswa;
  AssesmentModel? assesmentData;
  MateriModel? currentMateri;
  List<Assesment> get assesment => assesmentData?.assesments ?? [];

  eventChangeBantuan({required int value, required int index}) {
    // const int x1 = 1;
    // const int y1 = 6;
    // const int x2 = 5;
    // const int y2 = 13;

    // final int result = (y1 + ((value - x1) * (y2 - y1)) / (x2 - x1)).round();
    // assesment[index].helpful = result;
    assesment[index].helpful = value;
    update();
  }

  eventChangeKeaktifan({required int value, required int index}) {
    // const int x1 = 1;
    // const int y1 = 6;
    // const int x2 = 5;
    // const int y2 = 13;

    // final int result = (y1 + ((value - x1) * (y2 - y1)) / (x2 - x1)).round();
    // assesment[index].significant = result;
    assesment[index].significant = value;
    update();
  }

  eventSubmitAssesment() async {
    bool lanjut = true;
    for (var i = 0; i < assesment.length; i++) {
      if (assesment[i].helpful == 0 || assesment[i].significant == 0) {
        lanjut = false;
      }
    }

    if (!lanjut) {
      AppSnackbar.error(error: 'Tolong lengkapi rating bantuan dan keaktifan terlebih dahulu');
      return;
    }

    try {
      await repoPostAssesment(assesmentID: assesmentData?.assesmentId ?? '', assesments: assesment);
      update();
      AppSnackbar.succes(succes: 'Rating berhasil dikirim');
      await Get.offAndToNamed(RouteConstant.prepareQuiz, arguments: {'type': QuizTypeEnum.postQuiz, 'subjectId': currentMateri?.subjectId});
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() async {
    siswa = await AppStore.instance.siswa;
    final args = Get.arguments;

    if (args != null) {
      if (args['materi'] != null) {
        currentMateri = args['materi'] as MateriModel;
      }
    }

    update();

    _fetchAssesment();
    super.onInit();
  }

  _fetchAssesment() async {
    try {
      assesmentData = await repoGetAssesment(nis: siswa?.nis ?? 0);
      update();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
