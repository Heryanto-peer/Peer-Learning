import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/common/widget/app_snackbar.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/module/register/data/repo/register_repo.dart';
import 'package:fuzzy_mobile_user/module/register/widget/class_list_bottomsheet.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController with RegisterRepo {
  TextEditingController nis = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController kelas = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confrmPassword = TextEditingController();

  bool lookPassword = true;
  bool lookCnfrmPassword = true;

  Uint8List? image;

  bool submited = false;

  ClassModel? selectedClass;
  List<ClassModel> listClass = [];

  eventRegister() async {
    if (image == null) {
      AppSnackbar.error(error: 'Please Select Your Profile Picture');
      return;
    }
    if (name.text == '') {
      AppSnackbar.error(error: 'Please Fill Your Name');
      return;
    }
    if (nis.text == '') {
      AppSnackbar.error(error: 'Please Fill Your NIS');
      return;
    }
    if (password.text == '') {
      AppSnackbar.error(error: 'Please Fill Your Password');
      return;
    }
    if (confrmPassword.text == '') {
      AppSnackbar.error(error: 'Please Fill Your Confirm Password');
      return;
    }

    if (password.text != confrmPassword.text) {
      AppSnackbar.error(error: 'Password Does Not Match');
      return;
    }

    if (selectedClass == null) {
      AppSnackbar.error(error: 'Please Select Your Class');
      return;
    }

    submited = true;
    update();

    try {
      final imagePath = await repoUploadImageProfile(images: image!, nis: int.parse(nis.text));

      final Map<String, dynamic> data = {'nis': int.tryParse(nis.text), 'fullname': name.text, 'password': password.text, 'image_profile': imagePath, 'class_id': selectedClass?.classId};
      final res = await repoAddStudent(data: data);
      submited = false;
      update();
      if (res.status == 200) {
        await AppStore.instance.setSiswa(SiswaModel.fromJson(res.data));
        Get.offAllNamed(RouteConstant.login);
        AppSnackbar.succes(succes: 'Register Success, please login your account');
      } else {
        AppSnackbar.error(error: '[${res.status}] Failled for register your account');
      }
    } catch (e) {
      submited = false;
      update();
      AppSnackbar.error(error: e.toString());
    }
  }

  eventSelectedClass() async {
    final res = await ClassListBottomSheet.show(kelasModel: listClass) as ClassModel?;

    if (res != null) {
      selectedClass = res;
      kelas.text = res.className ?? '';
      update();
    }
  }

  @override
  void onInit() async {
    await _fetchKelas();
    super.onInit();
  }

  pickImageProfile() async {
    final res = await ImagePicker().pickImage(source: ImageSource.gallery);
    image = await res?.readAsBytes();
    update();
  }

  toggleCnfrmPassword() {
    lookCnfrmPassword = !lookCnfrmPassword;
    update();
  }

  togglePassword() {
    lookPassword = !lookPassword;
    update();
  }

  _fetchKelas() async {
    final res = await repoGetAllKelas();
    if (res.status == 200) {
      listClass = List<ClassModel>.from(res.data.map((e) => ClassModel.fromJson(e)));
      update();
    }
  }
}
