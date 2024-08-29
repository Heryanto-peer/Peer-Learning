import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/widget/pagination/app_pagination.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/controller/quiz_controller.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/data/utils/quiz_type_enum.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/widget/update_question.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (QuizController controller) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Get.offAllNamed(RouteConstant.home),
                icon: Icon(Icons.arrow_back, color: AppColors.black.primary),
              ),
              title: Text('Quiz ${controller.mapel}', style: AppTextStyle.s18w700()),
            ),
            body: controller.loading == true
                ? const Center(child: CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      SliverList.list(children: [
                        Column(
                          children: [
                            const Gap(20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Materi Pembelajaran', style: AppTextStyle.s24w700()),
                                  const Spacer(),
                                  SizedBox(width: 200, child: dropDownTypeQuiz()),
                                  const Gap(20),
                                  SizedBox(
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        await controller.convertExcelToObject();
                                        ();
                                      },
                                      child: const Text(
                                        'Quiz From Excel',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            const Divider(
                              thickness: 5,
                            ),
                            const Gap(20),
                          ],
                        ),
                        Center(
                          child: Scrollbar(
                            controller: controller.scrollController,
                            child: SingleChildScrollView(
                              controller: controller.scrollController,
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                border: TableBorder(
                                  horizontalInside: BorderSide(
                                    color: AppColors.grey.primary,
                                    width: 1,
                                  ),
                                ),
                                headingRowColor: WidgetStatePropertyAll(AppColors.white.primary),
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'NO',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Type Quiz',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Pertanyaan',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                    label: Text(
                                      'Jawaban',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.s16w700(),
                                    ),
                                    onSort: (columnIndex, ascending) {
                                      debugPrint(columnIndex.toString());
                                    },
                                  ),
                                  DataColumn(
                                      label: Text(
                                    'Opsi Ke-1',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Opsi Ke-2',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Opsi Ke-3',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Opsi Ke-4',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Tips',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Action',
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.s16w700(),
                                  )),
                                ],
                                rows: List.generate(
                                  controller.quizList.length,
                                  (index) {
                                    return DataRow(
                                      color: WidgetStatePropertyAll(AppColors.white.table),
                                      cells: [
                                        DataCell(Text(
                                          '${index + 1}',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.s12w700(),
                                        )),
                                        DataCell(Text(
                                          controller.quizList[index].type ?? '',
                                          textAlign: TextAlign.center,
                                          style: AppTextStyle.s12w700(),
                                        )),
                                        DataCell(SizedBox(
                                          width: Get.width * 0.2,
                                          child: Text(
                                            controller.quizList[index].question ?? '',
                                            textAlign: TextAlign.justify,
                                            style: AppTextStyle.s12w700(),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width: Get.width * 0.1,
                                          child: Text(
                                            controller.quizList[index].answer ?? '-',
                                            textAlign: TextAlign.justify,
                                            style: AppTextStyle.s12w700(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width: Get.width * 0.1,
                                          child: Text(
                                            controller.quizList[index].option1 ?? '-',
                                            textAlign: TextAlign.justify,
                                            style: AppTextStyle.s12w700(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width: Get.width * 0.1,
                                          child: Text(
                                            controller.quizList[index].option2 ?? '-',
                                            textAlign: TextAlign.justify,
                                            style: AppTextStyle.s12w700(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width: Get.width * 0.1,
                                          child: Text(
                                            controller.quizList[index].option3 ?? '-',
                                            textAlign: TextAlign.justify,
                                            style: AppTextStyle.s12w700(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(SizedBox(
                                          width: Get.width * 0.1,
                                          child: Text(
                                            controller.quizList[index].option4 ?? '-',
                                            textAlign: TextAlign.justify,
                                            style: AppTextStyle.s12w700(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )),
                                        DataCell(Text(controller.quizList[index].tips?.toString() ?? '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                                        DataCell(
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  final res = await Get.dialog(UpdateQuestion(
                                                        quiz: controller.quizList[index],
                                                      )) ??
                                                      false;
                                                  if (res) {
                                                    controller.getQuizBySubject();
                                                  }
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  controller.onDeleteQuiz(questionID: controller.quizList[index].questionId ?? '');
                                                },
                                                icon: Icon(Icons.delete, color: AppColors.red.error),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        fillOverscroll: true,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AppPagination(
                              pageTotal: controller.pagination.totalPage ?? 0,
                              pageInit: controller.pagination.page ?? 1,
                              onPageChanged: (x) {
                                controller.onChangeOfPage(x);
                              }),
                        ),
                      )
                    ],
                  ));
      },
    );
  }

  Widget dropDownTypeQuiz() {
    return GetBuilder<QuizController>(builder: (c) {
      return DropdownButtonFormField(
        items: QuizTypeEnum.values
            .map(
              (e) => DropdownMenuItem(
                value: ConvertQuizTypeEnum.reverse(e),
                child: Text(ConvertQuizTypeEnum.reverse(e) ?? ''),
              ),
            )
            .toList(),
        hint: const Text('Pilih Tipe Quiz'),
        onChanged: (choice) {
          c.setTypeQuiz(ConvertQuizTypeEnum.convert(choice));
        },
      );
    });
  }
}
