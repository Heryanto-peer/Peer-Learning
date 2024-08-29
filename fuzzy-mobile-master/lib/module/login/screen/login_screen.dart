import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/common/widget/app_textformfield.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/login/controller/login_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (LoginController controller) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.base.tertiary,
                  AppColors.base.tertiary.withOpacity(0.8),
                  AppColors.base.primary,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.0,
                  0.2,
                  1.0,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.bold,
                                color: AppColors.base.primary,
                              ),
                            ),
                            Text(
                              'Log In',
                              style: TextStyle(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: AppColors.base.secondary,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Image.asset(
                            AppAssets.logoApp,
                            width: 250,
                            height: 250,
                          ),
                        ),
                        const Gap(10),
                        const Text(
                          'Bersahabat dengan Angka\nKeajaiban Matematika di Ujung Jari Anda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DottedBorder(
                      color: AppColors.base.neonGreen,
                      strokeWidth: 1,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      dashPattern: const [5, 10],
                      radius: const Radius.circular(25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextFormField(
                            title: 'NIS',
                            controller: controller.nis,
                            hintText: 'Masukkan NIS',
                            keyboardType: TextInputType.number,
                          ),
                          AppTextFormField(
                            title: 'Password',
                            controller: controller.password,
                            obscureText: controller.lookPassword,
                            hintText: 'Masukkan Password',
                            suffix: InkWell(
                                onTap: () {
                                  controller.togglePassword();
                                },
                                child: Icon(
                                  controller.lookPassword ? Icons.visibility : Icons.visibility_off,
                                  color: controller.lookPassword ? AppColors.base.neonGreen : AppColors.base.grey,
                                )),
                          ),
                          const Gap(8),
                          AppButton(
                            onPressed: () {
                              controller.eventLogin();
                            },
                            text: 'Masuk Permainan',
                            background: AppColors.usedFor.buttonBox2,
                            foreground: AppColors.base.primary,
                          ),
                          const Gap(10)
                        ],
                      ),
                    ),
                  ),
                  const Gap(16),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Belum punya akun? ',
                      style: AppTextStyle.s10w400(color: AppColors.base.tertiary),
                      children: [
                        TextSpan(
                          text: 'Daftar Sekarang',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.eventRegister();
                            },
                          style: AppTextStyle.s11w700(color: AppColors.base.tertiary),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
