import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:get/get.dart';

class AppSnackbar {
  static void error({required String error, SnackPosition? position}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.base.red,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        snackPosition: position ?? SnackPosition.TOP,
        message: error,
        icon: RotatedBox(
          quarterTurns: 90,
          child: Icon(
            Icons.cancel,
            color: AppColors.usedFor.icon,
            weight: 10,
            opticalSize: 100,
          ),
        ),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        messageText: Text(
          error,
          style: AppTextStyle.s14w700(color: AppColors.usedFor.popupText),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25),
      ),
    );
  }

  static void succes({required String succes, SnackPosition? position}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.usedFor.popupBox,
        duration: const Duration(seconds: 3),
        isDismissible: true,
        snackPosition: position ?? SnackPosition.TOP,
        message: succes,
        icon: Icon(
          Icons.check_circle,
          color: AppColors.usedFor.icon,
          weight: 10,
          opticalSize: 100,
        ),
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        messageText: Text(succes, style: AppTextStyle.s14w700(color: AppColors.usedFor.popupText)),
        margin: const EdgeInsets.symmetric(horizontal: 25),
      ),
    );
  }
}
