import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/materi/controller/materi_controller.dart';
import 'package:fuzzy_web_admin/module/homes/materi/widget/add_materi.dart';
import 'package:fuzzy_web_admin/module/homes/materi/widget/materi_bottomsheet.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class MateriScreen extends StatelessWidget {
  const MateriScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MateriController>(
      init: MateriController(),
      builder: (MateriController controller) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: AppColors.white.primary, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: CustomScrollView(
            slivers: [
              SliverList.list(children: [
                Column(
                  children: [
                    const Gap(20),
                    Row(
                      children: [
                        Text('Materi Pembelajaran', style: AppTextStyle.s24w700()),
                        const Spacer(),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    controller.eventAddMapel();
                                  },
                                  icon: const Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.blue.primary,
                                    foregroundColor: AppColors.white.primary,
                                  ),
                                  label: const Text('Materi')),
                            ),
                          ],
                        ),
                      ],
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
                            'No. ',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.s16w700(),
                          )),
                          DataColumn(
                            label: Text(
                              'Nama Mapel',
                              textAlign: TextAlign.center,
                              style: AppTextStyle.s16w700(),
                            ),
                            onSort: (columnIndex, ascending) {
                              debugPrint(columnIndex.toString());
                            },
                          ),
                          DataColumn(
                              label: Text(
                            'Guru Mapel',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.s16w700(),
                          )),
                          DataColumn(
                              label: Text(
                            'Materi',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.s16w700(),
                          )),
                          DataColumn(
                              label: Text(
                            'Quiz',
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
                          controller.materiList.length,
                          (index) {
                            return DataRow(
                              color: WidgetStatePropertyAll(AppColors.white.table),
                              cells: [
                                DataCell(Text(
                                  '${index + 1}',
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle.s12w700(),
                                )),
                                DataCell(Text(controller.materiList[index].subjectName ?? '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                                DataCell(Text(controller.materiList[index].teacherName ?? '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                                DataCell(
                                  Text(controller.materiList[index].materisModel?.isNotEmpty == true ? 'Lihat Materi' : '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700()),
                                  onTap: controller.materiList[index].materisModel?.isNotEmpty == true
                                      ? () async {
                                          final refresh =
                                              await MateriBottomsheet.show(materisModel: controller.materiList[index].materisModel!, subjectID: controller.materiList[index].subjectId ?? '-');
                                          if (refresh) {
                                            controller.getRepoMateri();
                                          }
                                        }
                                      : null,
                                ),
                                DataCell(Text('lihat Quiz', textAlign: TextAlign.center, style: AppTextStyle.s12w700()), onTap: () async {
                                  await Get.toNamed(RouteConstant.quiz,
                                      parameters: {'subject_id': controller.materiList[index].subjectId ?? '-', 'mapel': controller.materiList[index].subjectName ?? '-'});
                                  controller.getRepoMateri();
                                }),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          final refresh = await Get.dialog(AddMateri(subjectID: controller.materiList[index].subjectId ?? '-')) ?? false;

                                          if (refresh) {
                                            controller.getRepoMateri();
                                          }
                                        },
                                        icon: Icon(Icons.add_link, color: AppColors.blue.primary),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller.eventDeleteSubject(controller.materiList[index].subjectId ?? '-');
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
            ],
          ),
        );
      },
    );
  }
}
