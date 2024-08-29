import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void error({required String title, required String error}) {
    Get.snackbar(title, error, backgroundColor: AppColors.red.error, colorText: Colors.white, duration: const Duration(seconds: 1), isDismissible: true);
  }

  static void succes({required String title, required String succes}) {
    Get.snackbar(title, succes, backgroundColor: AppColors.green.success, colorText: Colors.white, duration: const Duration(seconds: 1), isDismissible: true);
  }
}
