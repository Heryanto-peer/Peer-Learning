import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/controller/kelas_controller.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/kelas_model.dart';
import 'package:fuzzy_web_admin/module/homes/materi/screen/materi_screen.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class KelasScreen extends StatelessWidget {
  const KelasScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KelasController>(
      init: KelasController(),
      builder: (KelasController controller) {
        return Scaffold(
          body: Stack(
            children: [
              if (controller.isLoading)
                Container(
                  color: AppColors.grey.primary.withOpacity(0.3),
                ),
              if (controller.isLoading) const LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Gap(30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 277,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blue.primary),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Text(' ${controller.teacher?.fullname ?? ''}', style: AppTextStyle.s24w800()),
                                    Text('NIP : ${controller.teacher?.nip ?? ''}', style: AppTextStyle.s14w400()),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.logout();
                              },
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.base.red,
                                  ),
                                  child: Icon(
                                    Icons.logout,
                                    color: AppColors.base.tertiary,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(15),
                    const Divider(
                      thickness: 5,
                      height: 0,
                    ),
                    Container(
                      height: Get.height * 0.15,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3))],
                        color: AppColors.grey.primary.withOpacity(0.4),
                      ),
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (_, index) {
                            if (index == controller.listKelas.length) {
                              return InkWell(
                                onTap: () {
                                  controller.eventAddNewKelas();
                                },
                                child: Container(
                                  width: 150,
                                  height: 100,
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.white.primary,
                                    boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3))],
                                  ),
                                  child: Text(
                                    '+ Kelas',
                                    style: AppTextStyle.s26w700(color: AppColors.blue.primary),
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                              child: kelasContainer(controller.listKelas[index], controller),
                            );
                          },
                          separatorBuilder: (_, index) => const Gap(20),
                          itemCount: controller.listKelas.length + 1),
                    ),
                    const Divider(
                      thickness: 5,
                      height: 0,
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Column(
                              children: [
                                const Gap(10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Data Siswa', style: AppTextStyle.s24w700()),
                                    Expanded(
                                        child: SizedBox(
                                      height: 40,
                                      child: ListView(
                                        shrinkWrap: true,
                                        reverse: true,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  controller.eventNewSiswa();
                                                },
                                                child: const Text('+ Siswa')),
                                          ),
                                          const Gap(10),
                                          SizedBox(
                                            width: 120,
                                            child: ElevatedButton.icon(
                                                onPressed: controller.listGroup.isNotEmpty || controller.listSiswa.length < 10
                                                    ? null
                                                    : () {
                                                        controller.eventAddGroup();
                                                      },
                                                icon: const Icon(Icons.auto_awesome_motion),
                                                label: const Text('group')),
                                          ),
                                          const Gap(10),
                                          SizedBox(
                                            width: 150,
                                            child: ElevatedButton.icon(
                                                onPressed: controller.listGroup.isEmpty
                                                    ? null
                                                    : () {
                                                        controller.eventLeaderboardClass();
                                                      },
                                                icon: const Icon(Icons.leaderboard),
                                                label: const Text('leaderboard')),
                                          ),
                                          const Gap(10),
                                          SizedBox(
                                            width: 120,
                                            child: ElevatedButton.icon(
                                                onPressed: () {
                                                  // Get.toNamed(RouteConstant.materi);
                                                  Get.bottomSheet(const MateriScreen());
                                                },
                                                icon: const Icon(Icons.library_books),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: AppColors.blue.primary,
                                                  foregroundColor: AppColors.white.primary,
                                                ),
                                                label: const Text('Materi')),
                                          ),
                                          const Gap(10),
                                          SizedBox(
                                            width: 120,
                                            child: ElevatedButton.icon(
                                                onPressed: () {
                                                  controller.eventActiveCourse();
                                                },
                                                icon: Icon(controller.course == null ? Icons.close : Icons.check),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: controller.course != null ? AppColors.blue.primary : AppColors.red.primary,
                                                  foregroundColor: AppColors.white.primary,
                                                ),
                                                label: const Text('Course')),
                                          ),
                                          if (controller.course != null) ...[
                                            const Gap(10),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: AppColors.blue.primary),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 150,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          controller.eventCountPointGorup();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: controller.course != null ? AppColors.blue.primary : AppColors.red.primary,
                                                          foregroundColor: AppColors.white.primary,
                                                        ),
                                                        child: const Text('point group')),
                                                  ),
                                                  const Gap(10),
                                                  SizedBox(
                                                    width: 120,
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          controller.eventCountFuzzy();
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: controller.course != null ? AppColors.blue.primary : AppColors.red.primary,
                                                          foregroundColor: AppColors.white.primary,
                                                        ),
                                                        child: const Text('Fuzzy')),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                                const Gap(16),
                                if (controller.listGroup.isNotEmpty || controller.listSiswa.length < 10)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.red.primary.withOpacity(0.4),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '! Minimal 10 Siswa untuk mengaktifkan generate group',
                                        style: AppTextStyle.s16w700(color: AppColors.red.primary.withOpacity(0.4)),
                                      ),
                                    ),
                                  ),
                                const Gap(16),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                                    child: CustomScrollView(slivers: [
                                      SliverToBoxAdapter(
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
                                            'NIS',
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.s16w700(),
                                          )),
                                          DataColumn(
                                            label: Text(
                                              'Nama',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.s16w700(),
                                            ),
                                            onSort: (columnIndex, ascending) {
                                              debugPrint(columnIndex.toString());
                                            },
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Group',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.s16w700(),
                                            ),
                                            onSort: (columnIndex, ascending) {
                                              debugPrint(columnIndex.toString());
                                            },
                                          ),
                                          DataColumn(
                                            label: Text(
                                              'Poin Kontribusi',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyle.s16w700(),
                                            ),
                                            onSort: (columnIndex, ascending) {
                                              debugPrint(columnIndex.toString());
                                            },
                                          ),
                                          DataColumn(
                                              label: Text(
                                            'Action',
                                            textAlign: TextAlign.center,
                                            style: AppTextStyle.s16w700(),
                                          )),
                                        ],
                                        rows: List.generate(
                                          controller.listSiswa.length,
                                          (index) {
                                            return DataRow(
                                              cells: [
                                                DataCell(Text(controller.listSiswa[index].nis?.toString() ?? '')),
                                                DataCell(Text(controller.listSiswa[index].fullname ?? '')),
                                                DataCell(Text(controller.listSiswa[index].group?.groupName ?? ''),
                                                    onTap: controller.listSiswa[index].group == null
                                                        ? null
                                                        : () {
                                                            controller.eventlookupGroup(group: controller.listSiswa[index].group!);
                                                          }),
                                                DataCell(Text('${controller.listSiswa[index].contributes ?? 0}')),
                                                DataCell(
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          controller.eventUpdateSiswa(siswa: controller.listSiswa[index]);
                                                        },
                                                        icon: const Icon(Icons.edit),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          controller.eventDeleteSiswa(siswa: controller.listSiswa[index]);
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
                                      )),
                                      //                 SliverFillRemaining(
                                      //   hasScrollBody: false,
                                      //   fillOverscroll: true,
                                      //   child: Align(
                                      //     alignment: Alignment.bottomCenter,
                                      //     child: AppPagination(
                                      //         pageTotal: controller.pagination.totalPage ?? 0,
                                      //         pageInit: controller.pagination.page ?? 1,
                                      //         onPageChanged: (x) {
                                      //           controller.onChangeOfPage(x);
                                      //         }),
                                      //   ),
                                      // ),
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget kelasContainer(KelasModel kelas, KelasController controller) {
    final bool actived = kelas.classId == controller.selectedKelas?.classId;
    return InkWell(
      onTap: () {
        controller.setSelectedKelas(kelas);
      },
      child: Container(
        width: 150,
        height: 100,
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: actived ? AppColors.grey.primary : AppColors.white.primary,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3))],
        ),
        child: Text(
          kelas.className ?? '',
          style: AppTextStyle.s26w700(color: actived ? AppColors.white.primary : AppColors.blue.primary),
        ),
      ),
    );
  }
}
