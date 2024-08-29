import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/materi_page/controller/materi_page_controller.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MateriPageScreen extends StatelessWidget {
  const MateriPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MateriPageController>(
      init: MateriPageController(),
      builder: (MateriPageController controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Materi Pembelajaran',
                  style: AppTextStyle.s24w800(color: AppColors.base.primary),
                  textAlign: TextAlign.center,
                ),
                const Gap(32),
                if (controller.materiList.isNotEmpty)
                  Expanded(
                    child: Theme(
                      data: Theme.of(Get.context!).copyWith(dividerColor: Colors.transparent),
                      child: ListView.separated(
                          itemBuilder: (_, index) {
                            return ExpansionTile(
                                maintainState: true,
                                controlAffinity: ListTileControlAffinity.trailing,
                                title: Text(
                                  controller.materiList[index].subjectName ?? '',
                                  style: AppTextStyle.s16w700(),
                                ),
                                dense: true,
                                childrenPadding: EdgeInsets.zero,
                                children: controller.materiList[index].materisModel != null
                                    ? List.generate((controller.materiList[index].materisModel?.length ?? 0) + 1, (x) {
                                        if (x == 0) {
                                          return ListTile(
                                            leading: const Icon(
                                              Icons.quiz,
                                              size: 18,
                                            ),
                                            title: Text(
                                              'Latihan Soal',
                                              style: AppTextStyle.s12w700(),
                                            ),
                                            dense: true,
                                            onTap: () async {
                                              await Get.toNamed(RouteConstant.prepareQuiz, arguments: {'type': QuizTypeEnum.practiceQuiz, 'subjectId': controller.materiList[index].subjectId});
                                            },
                                          );
                                        }
                                        return ListTile(
                                          title: Text(
                                            controller.materiList[index].materisModel?[x - 1].materiName ?? '',
                                            style: AppTextStyle.s12w500(),
                                          ),
                                          dense: true,
                                          onTap: () {
                                            controller.openFile(controller.materiList[index].materisModel?[x - 1].pathMateri ?? '');
                                          },
                                        );
                                      })
                                    : [const SizedBox()]);
                          },
                          separatorBuilder: (_, __) {
                            return Divider(
                              thickness: 1,
                              color: AppColors.base.primary,
                              height: 0,
                            );
                          },
                          itemCount: controller.materiList.length),
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
