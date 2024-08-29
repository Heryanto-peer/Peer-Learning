import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/widget/snackbar/app_snackbar.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';
import 'package:fuzzy_web_admin/module/login/data/repo/login_repo.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoginRepo {
  TextEditingController nis = TextEditingController();
  TextEditingController password = TextEditingController();
  bool lookPassword = true;

  eventLogin() async {
    if (nis.text.isEmpty || password.text.isEmpty) {
      AppSnackbar.error(
        title: 'Login Failed',
        error: 'All field must be filled',
      );
    }

    try {
      final res = await repoLogin(data: {'nip': int.tryParse(nis.text), 'password': password.text});
      AppSnackbar.succes(title: 'Login Success', succes: 'Welcome ${res.fullname}');

      await AppStore.instance.setGuru(res);
      Get.offAllNamed(RouteConstant.home);
    } on Exception catch (e) {
      AppSnackbar.error(title: 'Login Failed', error: e.toString());
    }
  }

  @override
  void onInit() async {
    if (await AppStore.instance.guru != null) {
      Get.offAllNamed(RouteConstant.home);
      return;
    }

    if (kDebugMode) {
      nis.text = '2311099';
      password.text = 'heyy123!';
    }
    super.onInit();
  }

  togglePassword() {
    lookPassword = !lookPassword;
    update();
  }
}
