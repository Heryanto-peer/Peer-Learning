import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/assets/appassets.dart';
import 'package:fuzzy_web_admin/common/widget/button/app_button.dart';
import 'package:fuzzy_web_admin/common/widget/input/app_textformfield.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/login/controller/login_controller.dart';
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
          body: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Appassets.bgLogin),
                      fit: BoxFit.cover,
                      opacity: 0.2,
                    ),
                  ),
                  child: formLogin(controller),
                ),
              ),
              Flexible(
                  child: Container(
                color: AppColors.white.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Appassets.animLogin),
                    Text('Fuzzy Web Admin', style: AppTextStyle.s24w800()),
                  ],
                ),
              )),
            ],
          ),
        );
      },
    );
  }

  Widget formLogin(LoginController controller) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(Get.width * 0.25, 0, 10, 0),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextFormField(
            title: 'NIP',
            controller: controller.nis,
            hintText: 'Masukkan NIP',
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
          ),
          const Gap(10)
        ],
      ),
    );
  }
}
