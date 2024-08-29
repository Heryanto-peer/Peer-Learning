import 'package:flutter/widgets.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/common/widget/snackbar/app_snackbar.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/kelas_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/widget/add_siswa.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/repo/siswa_repo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SiswaController extends GetxController with SiswaRepo {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String selectedFilter = 'All';
  List<String> filters = ['All', 'Kelas', 'Group'];
  String? tagFilter;

  List<SiswaModel> siswaList = [];
  PaginationModel pagination = PaginationModel(page: 1);

  Future<bool> addSiswa() async {
    final res = await Get.dialog(AddSiswa(
      groupList: const [],
      classActive: KelasModel(),
      onAddNewGroup: (value) {},
    )) as Map<String, dynamic>?;
    if (res == null) {
      return false;
    }
    if (res['image_profile'] != null) {
      final image = await repoUploadImageProfile(images: res['image_profile'], nis: res['nis']);
      res['image_profile'] = image;
    }

    try {
      final add = await repoAddStudent(data: res);
      if (add.data != null) {
        pagination.page = 1;
        update();
        await getStudent();
        AppSnackbar.succes(title: 'Add Siswa', succes: 'Add Siswa Success');
        return true;
      } else {
        AppSnackbar.error(title: 'Add Siswa', error: add.message ?? 'Add Siswa Failed');
        return false;
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      AppSnackbar.error(title: 'Add Siswa', error: e.toString());
      return false;
    }
  }

  deleteSiswa(int nis) async {
    final success = await repoDeleteStudent(nis: nis, password: 'i am root');
    if (success) {
      pagination.page = 1;
      update();
      await getStudent();
    }
  }

  getStudent() async {
    try {
      siswaList = [];
      final res = await repoGetAllStudent(limit: 2, page: pagination.page, search: searchController.text, tag: tagFilter);
      pagination = res.pagination ?? PaginationModel(page: 1);
      if (res.data != null) {
        siswaList = List<SiswaModel>.from(res.data!.map((e) => SiswaModel.fromJson(e)));
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  onChangeOfPage(int page) async {
    pagination.page = page;
    update();
    getStudent();
  }

  @override
  void onInit() {
    getStudent();
    super.onInit();
  }

  Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  void searchSiswa() {
    pagination.page = 1;
    update();
    getStudent();
  }

  /// Sets the selected filter and triggers an update.
  ///
  /// The [filter] parameter specifies the new filter to be set.
  ///
  /// This function updates the [selectedFilter] field with the provided [filter] value and triggers an update by calling the [update] function.
  void setSelectedFilter(String filter) {
    selectedFilter = filter;

    switch (filter) {
      case 'Kelas':
        tagFilter = '1';
        break;
      case 'Group':
        tagFilter = '2';
        break;
      default:
        tagFilter = '';
        break;
    }
    update();
  }
}
