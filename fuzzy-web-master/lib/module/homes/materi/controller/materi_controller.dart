import 'package:flutter/widgets.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/model/materi_model.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/repo/materi_repo.dart';
import 'package:fuzzy_web_admin/module/homes/materi/widget/add_mapel.dart';
import 'package:fuzzy_web_admin/module/login/data/model/teacher_model.dart';
import 'package:get/get.dart';

class MateriController extends GetxController with MateriRepo {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<MateriModel> materiList = [];
  TeacherModel? teacher;

  eventAddMapel() async {
    final res = await Get.dialog(const AddMapel()) as Map<String, dynamic>?;
    if (res == null) {
      return;
    }

    await repoAddSubject(data: res);
    getRepoMateri();
  }

  eventDeleteSubject(String subjectID) async {
    await repoDeleteSubject(subjectID: subjectID);
    getRepoMateri();
  }

  getRepoMateri() async {
    materiList = await repoGetAllMateri();
    update();
  }

  @override
  void onInit() async {
    teacher = await AppStore.instance.guru;
    if (teacher?.nip == null) {
      Get.offAllNamed(RouteConstant.login);
      return;
    }
    getRepoMateri();
    super.onInit();
  }
}
