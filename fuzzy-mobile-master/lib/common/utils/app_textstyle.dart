import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:get/get.dart';

class AppTextStyle {
  static TextStyle? s10w300({Color? color}) => Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontSize: 10, fontWeight: FontWeight.w300, color: color ?? AppColors.usedFor.text);
  static TextStyle? s10w400({Color? color}) => Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontSize: 10, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s10w800({Color? color}) => Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(fontSize: 10, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s11w400({Color? color}) => Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 11, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s11w600({Color? color}) => Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 11, fontWeight: FontWeight.w600, color: color ?? AppColors.usedFor.text);
  static TextStyle? s11w700({Color? color}) => Theme.of(Get.context!).textTheme.titleMedium?.copyWith(fontSize: 11, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s12w400({Color? color}) => Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s12w500({Color? color}) => Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: color ?? AppColors.usedFor.text);
  static TextStyle? s12w600({Color? color}) => Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: color ?? AppColors.usedFor.text);
  static TextStyle? s12w700({Color? color}) => Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s12w800({Color? color}) => Theme.of(Get.context!).textTheme.titleLarge?.copyWith(fontSize: 12, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s14w300({Color? color}) => Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w300, color: color ?? AppColors.usedFor.text);
  static TextStyle? s14w400({Color? color}) => Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s14w500({Color? color}) => Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: color ?? AppColors.usedFor.text);
  static TextStyle? s14w600({Color? color}) => Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: color ?? AppColors.usedFor.text);
  static TextStyle? s14w700({Color? color}) => Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s14w800({Color? color}) => Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(fontSize: 14, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s16w400({Color? color}) => Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s16w500({Color? color}) => Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: color ?? AppColors.usedFor.text);
  static TextStyle? s16w600({Color? color}) => Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: color ?? AppColors.usedFor.text);
  static TextStyle? s16w700({Color? color}) => Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s16w700Bold({Color? color}) => Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: color ?? AppColors.usedFor.text);
  static TextStyle? s16w800({Color? color}) => Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s18w400({Color? color}) => Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s18w500({Color? color}) => Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w500, color: color ?? AppColors.usedFor.text);
  static TextStyle? s18w600({Color? color}) => Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: color ?? AppColors.usedFor.text);
  static TextStyle? s18w700({Color? color}) => Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s18w800({Color? color}) => Theme.of(Get.context!).textTheme.displaySmall?.copyWith(fontSize: 18, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s21w400({Color? color}) => Theme.of(Get.context!).textTheme.displayMedium?.copyWith(fontSize: 21, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s21w600({Color? color}) => Theme.of(Get.context!).textTheme.displayMedium?.copyWith(fontSize: 21, fontWeight: FontWeight.w600, color: color ?? AppColors.usedFor.text);
  static TextStyle? s21w800({Color? color}) => Theme.of(Get.context!).textTheme.displayMedium?.copyWith(fontSize: 21, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s24w700({Color? color}) => Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s24w800({Color? color}) => Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.w800, color: color ?? AppColors.usedFor.text);
  static TextStyle? s26w700({Color? color}) => Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: 26, color: color ?? AppColors.usedFor.text);
  static TextStyle? s8w400({Color? color}) => Theme.of(Get.context!).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s8w500({Color? color}) => Theme.of(Get.context!).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500, color: color ?? AppColors.usedFor.text);
  static TextStyle? s8w700({Color? color}) => Theme.of(Get.context!).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? s9w400({Color? color}) => Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontSize: 9, fontWeight: FontWeight.w400, color: color ?? AppColors.usedFor.text);
  static TextStyle? s9w500({Color? color}) => Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontSize: 9, fontWeight: FontWeight.w500, color: color ?? AppColors.usedFor.text);
  static TextStyle? s9w700({Color? color}) => Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(fontSize: 9, fontWeight: FontWeight.w700, color: color ?? AppColors.usedFor.text);
  static TextStyle? sDynamic700({required double size, Color? color}) =>
      Theme.of(Get.context!).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.w700, fontSize: size, color: color ?? AppColors.usedFor.text);
}
