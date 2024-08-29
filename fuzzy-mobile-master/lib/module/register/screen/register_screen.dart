import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/common/widget/app_textformfield.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/register/controller/register_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (RegisterController controller) {
        return Scaffold(
          body: SafeArea(
              child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.base.tertiary,
                      AppColors.base.tertiary,
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
                child: _build(controller),
              ),
            ],
          )),
        );
      },
    );
  }

  Widget _body(RegisterController controller) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Gap(24),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            dashPattern: const [8, 4],
            color: AppColors.base.secondary,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Spacer(),
                  DottedBorder(
                    borderType: BorderType.Circle,
                    padding: EdgeInsets.zero,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: controller.image == null ? const AssetImage(AppAssets.userHolder) : MemoryImage(controller.image!) as ImageProvider,
                        radius: 50,
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 2,
                    child: AppButton(
                      onPressed: () {
                        controller.pickImageProfile();
                      },
                      text: 'Pilih Profile',
                      background: AppColors.base.secondary,
                      foreground: AppColors.usedFor.text,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          AppTextFormField(
            title: 'NIS',
            controller: controller.nis,
            keyboardType: TextInputType.number,
            hintText: 'Masukkan NIS Anda',
          ),
          AppTextFormField(
            title: 'Nama Lengkap',
            controller: controller.name,
            hintText: 'Masukkan Nama Anda',
          ),
          AppTextFormField(
            title: 'Kelas',
            controller: controller.kelas,
            enabled: false,
            hintText: 'Pilih Kelas Anda',
            onTap: () {
              controller.eventSelectedClass();
            },
            suffix: Icon(Icons.expand_more, color: AppColors.base.neonGreen),
          ),
          AppTextFormField(
            title: 'Password',
            controller: controller.password,
            obscureText: controller.lookPassword,
            hintText: 'Masukkan Password Anda',
            suffix: InkWell(
                onTap: () {
                  controller.togglePassword();
                },
                child: Icon(
                  controller.lookPassword ? Icons.visibility : Icons.visibility_off,
                  color: controller.lookPassword ? AppColors.base.neonGreen : AppColors.base.grey,
                )),
          ),
          AppTextFormField(
            title: 'Konfirmasi Password',
            controller: controller.confrmPassword,
            obscureText: controller.lookCnfrmPassword,
            hintText: 'Masukkan Konfirmasi Password Anda',
            suffix: InkWell(
                onTap: () {
                  controller.toggleCnfrmPassword();
                },
                child: Icon(
                  controller.lookCnfrmPassword ? Icons.visibility : Icons.visibility_off,
                  color: controller.lookCnfrmPassword ? AppColors.base.neonGreen : AppColors.base.grey,
                )),
          ),
          const Gap(24),
          AppButton(
            onPressed: () {
              controller.eventRegister();
            },
            text: 'Daftar Sekarang',
            background: AppColors.base.secondary,
            foreground: AppColors.usedFor.text,
            isLoading: controller.submited,
          ),
          const Gap(24),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Sudah punya akun? Ayo..!!! ',
              style: AppTextStyle.s10w400(color: AppColors.base.tertiary),
              children: [
                TextSpan(
                  text: ' Login',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.back();
                    },
                  style: AppTextStyle.s11w700(color: AppColors.base.tertiary),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _build(RegisterController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Gap(24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Image.asset(
                          AppAssets.logoApp,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Icon(
                          Icons.keyboard_return_rounded,
                          color: AppColors.base.secondary,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Registrasi Akun',
                style: AppTextStyle.s24w800(),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          Expanded(child: _body(controller)),
        ],
      ),
    );
  }
}
