import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      canvasColor: AppColors.base.tertiary,
      scaffoldBackgroundColor: AppColors.base.tertiary,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.light(
        primary: AppColors.base.primary,
        onPrimary: AppColors.base.tertiary,
        secondary: AppColors.base.secondary,
        onSecondary: AppColors.base.tertiary,
        surface: AppColors.base.tertiary,
      ));
}
