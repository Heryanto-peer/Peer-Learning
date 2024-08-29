import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/widget/app_snackbar.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/module/login/data/repo/login_repo.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoginRepo {
  TextEditingController nis = TextEditingController();
  TextEditingController password = TextEditingController();
  bool lookPassword = true;

  eventLogin() async {
    if (nis.text.isEmpty || password.text.isEmpty) {
      AppSnackbar.error(
        error: 'All field must be filled',
      );
    }

    try {
      final res = await repoLogin(data: {'nis': nis.text, 'password': password.text});
      AppSnackbar.succes(succes: 'Welcome ${res.fullname}');

      await AppStore.instance.setSiswa(res);
      Get.offAllNamed(RouteConstant.home);
    } on Exception catch (e) {
      AppSnackbar.error(error: e.toString());
    }
  }

  eventRegister() async {
    await Get.toNamed(RouteConstant.register, preventDuplicates: false);
  }

  @override
  void onInit() async {
    final siswa = await AppStore.instance.siswa;
    if (siswa != null) {
      AppSnackbar.succes(succes: 'Welcome back ${siswa.fullname}');
      Get.offAllNamed(RouteConstant.home);
    }
    super.onInit();
  }

  togglePassword() {
    lookPassword = !lookPassword;
    update();
  }
}
