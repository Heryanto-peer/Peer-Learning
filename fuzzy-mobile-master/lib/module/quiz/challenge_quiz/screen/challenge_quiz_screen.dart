import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/controller/challenge_quiz_controller.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChallengeQuizScreen extends StatelessWidget {
  const ChallengeQuizScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChallengeQuizController>(
      init: ChallengeQuizController(),
      builder: (ChallengeQuizController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              ConvertQuizType.convertQuizType(controller.typeQuiz),
              style: AppTextStyle.s21w800(color: AppColors.base.primary),
            ),
            leading: controller.typeQuiz == QuizTypeEnum.practiceQuiz
                ? const SizedBox()
                : Row(
                    children: [
                      const Gap(8),
                      Image.asset(
                        AppAssets.iconPoin,
                        height: 20,
                        width: 20,
                        color: AppColors.base.gold,
                      ),
                      Text(' ${controller.totalPoin}', style: AppTextStyle.s16w700()),
                    ],
                  ),
            leadingWidth: 120,
            actions: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: AppColors.base.primary,
                ),
              ),
            ],
            elevation: 2,
            backgroundColor: AppColors.base.tertiary,
            shadowColor: AppColors.base.tertiary,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: LinearProgressIndicator(
                  value: controller.countdown,
                  valueColor: AlwaysStoppedAnimation<Color>(controller.colorCountdown),
                  backgroundColor: AppColors.base.lightBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(100),
                )),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: controller.claimPoin != null ? 0.4 : 1,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(16),
                            Row(
                              children: [
                                Text('Pertanyaan', style: AppTextStyle.s18w700(color: AppColors.base.primary)),
                                const Spacer(),
                                Text('${controller.currentQuestion}/10', style: AppTextStyle.s16w700()),
                              ],
                            ),
                            const Gap(4),
                            Card.filled(
                              color: AppColors.base.tertiary,
                              elevation: 4,
                              shadowColor: AppColors.base.tertiary,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 500),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                                  child: Text(
                                    controller.currentQuestion > controller.totalQuestion ? '' : controller.listQuiz[controller.currentQuestion - 1].question ?? '',
                                    style: AppTextStyle.s16w400(),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(40),
                            if (controller.tips != null && controller.countdown <= 0.5) ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.tips_and_updates,
                                    color: AppColors.base.orange,
                                    size: 18,
                                  ),
                                  const Gap(5),
                                  Text('Tips : ', style: AppTextStyle.s12w700(color: AppColors.base.orange)),
                                  Expanded(child: Text(controller.tips ?? '', style: AppTextStyle.s12w400())),
                                ],
                              ),
                              const Gap(40),
                            ],
                            Text('Pilihan Jawaban', style: AppTextStyle.s18w700(color: AppColors.base.primary)),
                            const Gap(4),
                            ...controller.listChoice.entries.map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: AppButton(
                                  onPressed: controller.countdown <= 0.0
                                      ? null
                                      : () {
                                          controller.setLockedAnswer = e.key;
                                        },
                                  text: '${e.key} : ${e.value}',
                                  background: controller.lockedAnswer == e.key ? null : AppColors.base.tertiary,
                                  foreground: controller.lockedAnswer == e.key ? null : AppColors.base.black,
                                  borderColor: AppColors.base.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: Row(
                            children: [
                              const Gap(16),
                              // Icon(Icons.keyboard_return, color: AppColors.base.primary),
                              // const Gap(5),
                              // Text('Home', style: AppTextStyle.s14w700(color: AppColors.base.primary)),
                              const Spacer(flex: 2),
                              Expanded(
                                flex: 2,
                                child: AppButton(
                                  onPressed: controller.lockedAnswer != null && controller.countdown > 0.0 ? () => controller.eventChoice() : null,
                                  text: 'Pilih',
                                  background: AppColors.base.tertiary,
                                  foreground: AppColors.base.black,
                                  borderColor: AppColors.base.primary,
                                ),
                              ),
                              const Spacer(),

                              GestureDetector(
                                  onTap: () {
                                    controller.setLockedAnswer = null;
                                    controller.eventChoice();
                                  },
                                  child: Text(controller.currentQuestion == controller.totalQuestion ? 'Selesai' : 'Skip', style: AppTextStyle.s14w700(color: AppColors.base.primary))),
                              const Gap(5),
                              GestureDetector(
                                  onTap: () {
                                    controller.setLockedAnswer = null;
                                    controller.eventChoice();
                                  },
                                  child: Transform.flip(flipX: false, child: Icon(Icons.keyboard_arrow_right, color: AppColors.base.primary))),
                              const Gap(16),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (controller.claimPoin != null && controller.typeQuiz != QuizTypeEnum.practiceQuiz)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.base.tertiary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: AppColors.base.gold, blurRadius: 10, spreadRadius: 5),
                        ],
                      ),
                      child: Image.asset(
                        AppAssets.iconPoin,
                        height: 90,
                        width: 180,
                        color: AppColors.base.gold,
                      ),
                    ),
                    const Gap(16),
                    Text('+ ${controller.claimPoin ?? 0} Poin', style: AppTextStyle.s24w800()),
                    if ((int.tryParse(controller.claimPoin ?? '') ?? 0) <= 5 && controller.claimPoin != null) ...[
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: AppColors.base.tertiary,
                        child: Text(
                          '${controller.tagAnswer} : ${controller.keyAnswer}',
                          style: AppTextStyle.s24w800(color: AppColors.base.neonGreen),
                        ),
                      )
                    ]
                  ],
                )
              else if (controller.claimPoin != null && controller.typeQuiz == QuizTypeEnum.practiceQuiz)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: AppColors.base.tertiary,
                  child: Text((int.tryParse(controller.claimPoin ?? '') ?? 0) > 5 ? 'Jawaban benar' : '${controller.tagAnswer} : ${controller.keyAnswer}', style: AppTextStyle.s24w800()),
                )
            ],
          ),
        );
      },
    );
  }
}
