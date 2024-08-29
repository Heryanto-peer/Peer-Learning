import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/group_model.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/common/widget/app_snackbar.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/module/homepage/data/repo/homepage_repo.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:get/get.dart';

class HomepageController extends GetxController with HomepageRepo {
  SiswaModel? siswa;
  GroupModel? myGroup;
  List<GroupModel> listGroup = [];
  int? peringkat;

  eventDailyQuiz() async {
    await Get.toNamed(RouteConstant.prepareQuiz, arguments: {
      'type': QuizTypeEnum.dailyQuiZ,
    });
  }

  eventRefresh() {
    _fetchSiswa();
    _fetchMyGroup();
    _fetchAllGroup();
  }

  @override
  void onInit() async {
    siswa = await AppStore.instance.siswa;
    if (siswa == null) {
      Get.offAllNamed(RouteConstant.login);
      AppSnackbar.error(error: 'Please login first');
    }
    update();

    _fetchMyGroup();
    _fetchAllGroup();
    _fetchSiswa();

    super.onInit();
  }

  _fetchAllGroup() async {
    try {
      final res = await repoGetGroupByClassId(classId: siswa?.datumClass?.classId ?? '');
      listGroup = res;
      // sorting poin lebih tinggi lebih utamna
      listGroup.sort((a, b) => (b.totalPoin ?? 0).compareTo((a.totalPoin ?? 0)));
      update();

      listGroup.forEach((e) {
        if (e.groupId == siswa?.group?.groupId) {
          peringkat = listGroup.indexOf(e) + 1;
          update();
        }
      });
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  _fetchMyGroup() async {
    try {
      final id = siswa?.group?.groupId;
      if (id != null) {
        myGroup = null;
        update();
      }

      myGroup = await repoGetMyGroup(groupID: id!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _fetchSiswa() async {
    try {
      final res = await repoGetSiswa(nis: siswa?.nis ?? 0);

      await AppStore.instance.setSiswa(res);
      siswa = await AppStore.instance.siswa;
      update();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
