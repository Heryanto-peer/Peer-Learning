import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/widget/image/image_shimmer.dart';
import 'package:fuzzy_web_admin/common/widget/input/search_text_input.dart';
import 'package:fuzzy_web_admin/common/widget/pagination/app_pagination.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/controller/siswa_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SiswaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SiswaController>(
      init: SiswaController(),
      builder: (SiswaController controller) {
        return CustomScrollView(
          slivers: [
            SliverList.list(children: [
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Find By  :  ', style: AppTextStyle.s16w700()),
                        const Gap(15),
                        DropdownButton(
                          value: controller.selectedFilter,
                          items: List.generate(
                            controller.filters.length,
                            (index) {
                              return DropdownMenuItem(
                                value: controller.filters[index],
                                alignment: Alignment.center,
                                child: Text(
                                  controller.filters[index],
                                  style: AppTextStyle.s14w500(),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                          style: AppTextStyle.s14w500(),
                          dropdownColor: AppColors.white.primary,
                          focusColor: Colors.transparent,
                          onChanged: (_) {
                            controller.setSelectedFilter(_ as String);
                          },
                          alignment: Alignment.center,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: SearchTextInput(
                            controller: controller.searchController,
                            hintText: 'Cari Siswa...',
                            onSubmitted: (_) => controller.searchSiswa(),
                          ),
                        ),
                        const Gap(10),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              controller.searchSiswa();
                            },
                            child: const Text('Cari'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    width: Get.width * 0.1,
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.addSiswa();
                      },
                      child: const Text(
                        'Add Siswa',
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(35),
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
                          'Gambar Profile',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s16w700(),
                        )),
                        DataColumn(
                          label: Text(
                            'NIS',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.s16w700(),
                          ),
                          onSort: (columnIndex, ascending) {
                            debugPrint(columnIndex.toString());
                          },
                        ),
                        DataColumn(
                            label: Text(
                          'Nama',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s16w700(),
                        )),
                        DataColumn(
                            label: Text(
                          'Group Tugas',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s16w700(),
                        )),
                        DataColumn(
                            label: Text(
                          'Kelas',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s16w700(),
                        )),
                        DataColumn(
                            label: Text(
                          'Poin Kontribusi',
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
                        controller.siswaList.length,
                        (index) {
                          return DataRow(
                            color: WidgetStatePropertyAll(AppColors.white.table),
                            cells: [
                              DataCell(ImageShimmer(
                                url: controller.siswaList[index].imageProfile,
                                width: 50,
                                height: 50,
                                shape: BoxShape.rectangle,
                              )),
                              DataCell(Text(
                                '${controller.siswaList[index].nis ?? ''}',
                                textAlign: TextAlign.center,
                                style: AppTextStyle.s12w700(),
                              )),
                              DataCell(Text(controller.siswaList[index].fullname ?? '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                              DataCell(Text(controller.siswaList[index].group?.groupName ?? '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                              DataCell(Text(controller.siswaList[index].datumClass?.className ?? '-', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                              DataCell(Text('${controller.siswaList[index].contributes ?? '0'}', textAlign: TextAlign.center, style: AppTextStyle.s12w700())),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        controller.deleteSiswa(controller.siswaList[index].nis ?? 0);
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
        );
      },
    );
  }
}
