import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_mobile_user/module/quiz/result_quiz/controller/result_quiz_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ResultQuizScreen extends StatelessWidget {
  const ResultQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResultQuizController>(
      init: ResultQuizController(),
      builder: (ResultQuizController controller) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            appBar: AppBar(
              leading: const SizedBox(),
              backgroundColor: AppColors.base.primary,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                        color: AppColors.base.primary,
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.iconPoin,
                          height: 30,
                          width: 30,
                          color: AppColors.base.gold,
                        ),
                        const Gap(8),
                        Text('+ ${controller.totalPoin}', style: AppTextStyle.sDynamic700(size: 35, color: AppColors.base.gold)),
                      ],
                    ),
                  ),
                  ...[
                    const Gap(45),
                    Image.asset(
                      AppAssets.animCelebration,
                    ),
                    const Gap(24),
                    if (controller.typeQuiz == QuizTypeEnum.dailyQuiZ) ...[
                      Text(
                        'Selamat ${controller.siswa?.fullname}\nanda mendapatkan penambahan ${controller.totalPoin} poin\n di ${ConvertQuizType.convertQuizType(controller.typeQuiz)}',
                        style: AppTextStyle.s16w700(
                          color: AppColors.usedFor.text,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(24),
                      SizedBox(
                          width: Get.height * 0.2,
                          child: AppButton(
                              onPressed: () {
                                controller.eventExit();
                              },
                              text: 'Keluar'))
                    ],
                    if (controller.typeQuiz == QuizTypeEnum.preQuiz) ...[
                      Text('Terima kasih telah menyelesaikan pre-quiz, silahkan lanjut dengan membuka materi pembelajaran',
                          style: AppTextStyle.s16w700(color: AppColors.usedFor.text), textAlign: TextAlign.center),
                      const Gap(24),
                      SizedBox(
                        width: Get.height * 0.2,
                        child: AppButton(
                            onPressed: () {
                              controller.eventOpenMateri();
                            },
                            text: 'Buka Materi'),
                      )
                    ],
                    if (controller.typeQuiz == QuizTypeEnum.postQuiz) ...[
                      Text(
                        'Selamat ${controller.siswa?.fullname}\nanda mendapatkan penambahan ${controller.totalPoin} poin\n di ${ConvertQuizType.convertQuizType(controller.typeQuiz)}',
                        style: AppTextStyle.s16w700(
                          color: AppColors.usedFor.text,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(24),
                      SizedBox(
                          width: Get.height * 0.2,
                          child: AppButton(
                              onPressed: () {
                                controller.eventExit();
                              },
                              text: 'Selesai'))
                    ],
                  ]
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
