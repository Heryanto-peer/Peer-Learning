import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/common/utils/app_date_format.dart';
import 'package:fuzzy_web_admin/common/widget/snackbar/app_snackbar.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/course_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/group_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/kelas_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/repo/kelas_repo.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/add_kelas.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/add_siswa.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/edit_siswa.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/group_leaderboard.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/leaderboard.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/remove_user.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/setting_course.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/model/materi_model.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';
import 'package:fuzzy_web_admin/module/login/data/model/teacher_model.dart';
import 'package:get/get.dart';

class KelasController extends GetxController with KelasRepo {
  List<KelasModel> listKelas = [];
  List<SiswaModel> listSiswa = [];
  List<GroupModel> listGroup = [];
  List<MateriModel> listMateri = [];
  KelasModel? selectedKelas;
  PaginationModel pagination = PaginationModel(page: 1);
  bool isLoading = false;
  CourseModel? course;
  TeacherModel? teacher;

  List<List<int>> createdGroup() {
    final int total = (listSiswa.length);
    final List<List<int>> bags = [];
    final int totalBags = total ~/ 4;
    final List<int> holder = List.generate(total, (index) => index);
    holder.shuffle();

    for (int i = 0; i < totalBags; i++) {
      final List<int> list = [];
      for (int j = 0; j < 4; j++) {
        if (holder.isNotEmpty) {
          list.add(holder.first);
          holder.removeAt(0);
        }
      }

      bags.add(list);
    }

    for (var i = 0; i < bags.length; i++) {
      if (holder.isNotEmpty) {
        if (bags[i].length < 5) {
          bags[i].add(holder.first);
          holder.removeAt(0);
        }
      }
    }

    for (var i = 0; i < bags.length; i++) {
      if (bags[i].length == 4) {
        if (i < bags.length - 3) {
          bags[i].add(bags.last.first);
          bags.last.removeAt(0);
          if (bags.last.length == 3 && bags[i].length == 4) {
            bags[i + 1].addAll(bags.last);
            if (bags.last.isEmpty) {
              bags.removeLast();
            }
          }
        }
      }

      if (i == bags.length - 1 && bags.last.length == 3) {
        bags[i - 1].addAll(bags.last);
        bags.removeLast();
      }
    }

    final List<List<int>> temp = bags;

    for (var i = 0; i < temp.length; i++) {
      if (bags[i].isEmpty) {
        bags.removeAt(i);
      }
    }

    return bags;
  }

  eventActiveCourse() async {
    if (selectedKelas == null) return;
    isLoading = true;
    update();

    if (course != null) {
      final res = await repoRemoveCourse(classID: selectedKelas!.classId!);
      if (res != null) {
        AppSnackbar.succes(title: 'Success', succes: 'Course berhasil di hapus');
      } else {
        AppSnackbar.error(title: 'Error', error: 'Course gagal di hapus');
      }
      course = null;
      isLoading = false;
      update();

      return;
    }

    final res = await Get.dialog(SettingCourse(materi: listMateri)) as Map<String, dynamic>?;
    if (res == null) {
      isLoading = false;
      update();
      return false;
    }

    final data = {
      'class_id': selectedKelas?.classId,
      'subject_id': res['subject_id'],
      'start_course': res['start_course'],
      'end_course': res['end_course'],
    };

    final add = await repoAddCourse(data: data);

    course = add;

    if (add != null) {
      AppSnackbar.succes(title: 'Success', succes: 'Course berhasil di update');
    } else {
      AppSnackbar.error(title: 'Error', error: 'Course gagal di update');
    }
    await fetchCourse();
  }

  eventAddGroup() async {
    if (listGroup.isNotEmpty) return;
    if (listSiswa.length < 10) return;
    final scanning = createdGroup();
    isLoading = true;
    update();

    final List<Map<String, dynamic>> groups = [];
    final List<List<String>> students = [];

    try {
      for (var i = 0; i < scanning.length; i++) {
        if (scanning[i].length < 3) continue;
        final holder = {
          'class_id': selectedKelas?.classId,
          'group_name': 'Kelompok ${i + 1}',
        };

        groups.add(holder);
        final List<String> nisSiswa = [];
        for (var j = 0; j < scanning[i].length; j++) {
          if (scanning[i].length < 3) continue;
          try {
            nisSiswa.add(listSiswa[scanning[i][j]].nis.toString());
          } catch (e) {
            debugPrint('error add nis ${scanning[i][j]}');
          }
        }

        students.add(nisSiswa);
      }

      final res = await repoAddNewGroup(data: groups);
      for (var i = 0; i < res.length; i++) {
        await repoAddStudentIntoGroup(listSiswa: students[i], groupID: res[i].groupId.toString());
      }

      isLoading = false;
      update();
      AppSnackbar.succes(title: 'Success', succes: 'Kelompok berhasil di tambahkan');
      fetchSiswaKelas();
      fetchGroups();
    } on Exception catch (e) {
      isLoading = false;
      update();
      AppSnackbar.error(title: 'Error', error: 'Gagal menambahkan kelompok');
      debugPrint(e.toString());
    }
  }

  eventAddNewKelas() async {
    final res = await Get.dialog(const AddKelas()) as Map<String, dynamic>?;
    if (res == null) {
      return false;
    }

    final data = {'class_name': res['class_name'], 'nip': teacher?.nip};

    final add = await repoPostAddKelas(data: data);
    if (add.data != null) {
      AppSnackbar.succes(title: 'Success', succes: add.message ?? '');
    } else {
      AppSnackbar.error(title: 'Error', error: add.message ?? '');
    }
    fetchAllKelas();
  }

  eventCountFuzzy() async {
    if (selectedKelas == null) return;
    isLoading = true;
    update();
    try {
      final res = await repoCountFuzzy(classId: selectedKelas!.classId!, time: AppDateFormat.formatDate(dateTime: DateTime.now()));
      if (res.status == 200) {
        AppSnackbar.succes(title: 'Succes', succes: 'Update nilai fuzzy di kelas ${selectedKelas?.className} sukses');
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', error: e.toString());
    }

    isLoading = false;
    update();
  }

  eventCountPointGorup() async {
    if (selectedKelas == null) return;
    isLoading = true;
    update();
    try {
      final res = await repoCountPointGroup(classId: selectedKelas!.classId!);
      if (res.status == 200) {
        AppSnackbar.succes(title: 'Succes', succes: 'Update nilai fuzzy di kelas ${selectedKelas?.className} sukses');
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', error: e.toString());
    }

    isLoading = false;
    update();
  }

  eventDeleteSiswa({required SiswaModel siswa}) async {
    if (selectedKelas == null) return;
    final deleted = await Get.dialog(RemoveUser(
      siswa: siswa,
    ));

    if (!deleted) {
      return;
    }

    final res = await repoDeleteSiswa(nis: siswa.nis!, password: 'i am root');
    if (res) {
      AppSnackbar.succes(title: 'Success', succes: 'Siswa ${siswa.fullname} berhasil di hapus');
    } else {
      AppSnackbar.error(title: 'Error', error: 'Gagal menghapus siswa ${siswa.fullname}');
    }
    await fetchSiswaKelas();
  }

  eventLeaderboardClass() async {
    await Get.dialog(Leaderboard(listGroup: listGroup));
  }

  eventlookupGroup({required GroupModel group}) async {
    final myGroup = listGroup.firstWhereOrNull((element) => element.groupId == group.groupId);
    final List<SiswaModel> students = listSiswa.where((element) => element.group?.groupId == group.groupId).toList();
    final List<SiswaModel> outside = listSiswa.where((element) => element.group?.groupId != group.groupId).toList();
    outside.sort((a, b) => (a.group?.groupName ?? '0').compareTo(b.group?.groupName ?? '0'));
    final res = await Get.dialog(GroupLeaderboard(group: myGroup!, students: students, allStudent: outside));
    await fetchSiswaKelas();
    if (res == null) {
      return false;
    }
  }

  eventNewSiswa() async {
    if (selectedKelas == null) return;
    final res = await Get.dialog(AddSiswa(
      groupList: listGroup,
      classActive: selectedKelas!,
      onAddNewGroup: (value) {
        fetchGroups();
      },
    )) as Map<String, dynamic>?;
    if (res == null) {
      return false;
    }
    if (res['image_profile'] != null) {
      final image = await repoUploadImageProfile(images: res['image_profile'], nis: res['nis']);
      res['image_profile'] = image;
    }

    final add = await repoAddStudent(data: res);
    if (add.data != null) {
      AppSnackbar.succes(title: 'Success', succes: add.message ?? '');
    } else {
      AppSnackbar.error(title: 'Error', error: add.message ?? '');
    }
    fetchSiswaKelas();
  }

  eventSetPageSiswa(int page) {
    pagination.page = page;
    update();

    fetchSiswaKelas();
  }

  eventUpdateSiswa({required SiswaModel siswa}) async {
    if (selectedKelas == null) return;

    final detail = await repoGetDetailStudent(nis: siswa.nis.toString());

    final res = await Get.dialog(EditSiswa(
      siswa: detail,
    )) as Map<String, dynamic>?;
    if (res == null) {
      return false;
    }
    if (res['image_profile'] != null) {
      final image = await repoUploadImageProfile(images: res['image_profile'], nis: res['nis']);
      res['image_profile'] = image;
    } else {
      res['image_profile'] = siswa.imageProfile;
    }

    res.addAll({'key_pas': 'iam root'});

    if (res['password'].toString().isNotEmpty == false) {
      res['password'] = detail.password;
    }

    final add = await repoUpdateStudent(data: res);
    if (add.data != null) {
      AppSnackbar.succes(title: 'Success', succes: add.message ?? '');
    } else {
      AppSnackbar.error(title: 'Error', error: add.message ?? '');
    }
    fetchSiswaKelas();
  }

  fecthAllCourse() async {
    try {
      listMateri = await repoGetAllMateri();
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  fetchAllKelas() async {
    try {
      final res = await getAllKelas();
      if (res.status == 200) {
        listKelas = List<KelasModel>.from(res.data.map((x) => KelasModel.fromJson(x)));
        update();
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  fetchCourse() async {
    if (selectedKelas == null) return;

    isLoading = true;
    course = null;
    update();

    try {
      course = await repoGetCourse(classID: selectedKelas!.classId!);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }

  fetchGroups() async {
    isLoading = true;
    update();
    if (selectedKelas == null) return;
    listGroup = await repoGetGroupByClassId(classId: selectedKelas!.classId!);
    listGroup.sort((a, b) => (b.totalPoin ?? 0).compareTo((a.totalPoin ?? 0)));

    isLoading = false;
    update();
  }

  fetchSiswaKelas() async {
    if (selectedKelas == null) {
      listSiswa = [];
      update();
      return;
    }

    isLoading = true;
    update();

    try {
      final res = await repoGetSiswaKelas(selectedKelas!.classId!);
      if (res.data['students'] != null) {
        listSiswa = List<SiswaModel>.from(res.data['students'].map((x) => SiswaModel.fromJson(x)));
      } else {
        listSiswa = [];
      }
      update();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }

  logout() async {
    await AppStore.instance.removeGuru();
    Get.offAllNamed(RouteConstant.login);
  }

  @override
  void onInit() async {
    teacher = await AppStore.instance.guru;
    if (teacher?.nip == null) {
      Get.offAllNamed(RouteConstant.login);
      return;
    }
    await fecthAllCourse();
    await fetchAllKelas();
    if (listKelas.isNotEmpty) {
      setSelectedKelas(listKelas.first);
    }
    super.onInit();
  }

  resetData() {
    listSiswa = [];
    listGroup = [];
    selectedKelas = null;
    pagination = PaginationModel(page: 1);
    isLoading = false;
    update();
  }

  setSelectedKelas(KelasModel? value) async {
    try {
      resetData();
      selectedKelas = value;
      update();
      await fetchSiswaKelas();
      await fetchGroups();
      await fetchCourse();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
