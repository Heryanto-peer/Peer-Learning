import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_date_format.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_mobile_user/module/quiz/prepare_quiz/controller/prepare_quiz_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PrepareQuizScreen extends StatelessWidget {
  const PrepareQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrepareQuizController>(
      init: PrepareQuizController(),
      builder: (PrepareQuizController controller) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Gap(Get.height * 0.1),
                        Text(ConvertQuizType.convertQuizType(controller.typeQuiz), style: AppTextStyle.s24w700(color: AppColors.base.primary)),
                        const Gap(16),
                        if (controller.typeQuiz == QuizTypeEnum.dailyQuiZ)
                          Text(
                            AppDateFormat.formatDateTime(dateTime: DateTime.now()),
                            style: AppTextStyle.s14w400(color: AppColors.base.primary),
                          )
                        else if (controller.typeQuiz == QuizTypeEnum.practiceQuiz)
                          Text(
                            controller.currentMateri?.subjectName ?? '',
                            style: AppTextStyle.s18w400(color: AppColors.base.primary),
                          ),
                        const Gap(16),
                        Expanded(
                          child: Image.asset(
                            AppAssets.animQuizPrepare,
                            height: Get.width * 0.8,
                            width: Get.width * 0.8,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.zero,
                    color: AppColors.base.primary,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const Gap(16),
                          Text('Perhatian !', style: AppTextStyle.s16w700(color: AppColors.base.red)),
                          const Gap(16),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(text: '${ConvertQuizType.convertQuizType(controller.typeQuiz).capitalizeFirst} ini berisi '),
                              TextSpan(text: '10', style: AppTextStyle.s14w700(color: AppColors.base.tertiary)),
                              TextSpan(
                                text:
                                    ' soal ${controller.typeQuiz == QuizTypeEnum.dailyQuiZ ? 'harian' : controller.currentMateri?.subjectName} dengan pilihan ganda masing-masing soal di batasi waktu pengerjaan selama ',
                              ),
                              TextSpan(text: '90', style: AppTextStyle.s14w700(color: AppColors.base.tertiary)),
                              TextSpan(
                                  text:
                                      ' detik \n\ndiharapkan menjawab semua soal dan tidak keluar dari aplikasi ini selama menyelesaikan ${ConvertQuizType.convertQuizType(controller.typeQuiz).toLowerCase()}'),
                            ], style: AppTextStyle.s14w400(color: AppColors.base.tertiary)),
                          ),
                          const Gap(40),
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  onPressed: controller.typeQuiz == QuizTypeEnum.postQuiz
                                      ? null
                                      : () {
                                          Get.back();
                                        },
                                  text: 'Kembali',
                                  background: AppColors.base.tertiary,
                                  foreground: AppColors.base.primary,
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: AppButton(
                                  onPressed: controller.listQuiz.isNotEmpty
                                      ? () {
                                          // controller.prepareQuiz();
                                          // Get.back();
                                          controller.eventStartQuiz();
                                        }
                                      : null,
                                  text: 'Mulai',
                                  borderColor: AppColors.base.tertiary,
                                ),
                              ),
                            ],
                          ),
                          Gap(Get.height * 0.05)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              if (controller.countdown != null) Text('${controller.countdown}', style: AppTextStyle.sDynamic700(size: 120, color: AppColors.base.red))
            ],
          ),
        );
      },
    );
  }
}
