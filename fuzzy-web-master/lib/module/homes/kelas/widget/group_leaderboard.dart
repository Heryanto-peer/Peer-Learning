import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/common/widget/snackbar/app_snackbar.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/group_model.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/network/kelas_network.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class GroupLeaderboard extends StatefulWidget {
  final List<SiswaModel> allStudent;
  final GroupModel group;
  final List<SiswaModel> students;
  const GroupLeaderboard({super.key, required this.group, required this.students, required this.allStudent});

  @override
  State<GroupLeaderboard> createState() => _GroupLeaderboardState();
}

class _GroupLeaderboardState extends State<GroupLeaderboard> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Expanded(child: Text('Leaderboard ${widget.group.groupName}')),
          IconButton(
            onPressed: widget.students.length > 4
                ? null
                : () async {
                    final picked = await Get.bottomSheet(Container(
                      padding: const EdgeInsets.all(20),
                      width: Get.width * 0.5,
                      decoration: BoxDecoration(
                        color: AppColors.white.primary,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.allStudent.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.back(result: widget.allStudent[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  '${widget.allStudent[index].fullname} - ${widget.allStudent[index].group?.groupName ?? 'Belum Ada Group'}',
                                ),
                              ),
                            );
                          }),
                    )) as SiswaModel?;

                    if (picked == null) {
                      return;
                    }

                    final repo = await KelasNetwork().addStudentIntoGroup(
                      groupID: widget.group.groupId!,
                      listSiswa: [picked.nis.toString()],
                    );

                    if (repo.status == 200) {
                      AppSnackbar.succes(title: 'Success', succes: 'Succes Add Student Into Group');
                    } else {
                      AppSnackbar.error(title: 'Error', error: 'Error Add Student');
                    }
                    Get.back(closeOverlays: true);
                  },
            icon: Icon(
              Icons.person_add_alt_1_rounded,
              color: widget.students.length > 4 ? AppColors.grey.primary : AppColors.blue.primary,
            ),
          ),
        ],
      ),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        const Gap(10),
        Text('Total Poin: ${widget.group.totalPoin ?? 0}', style: AppTextStyle.s16w700()),
        const Gap(20),
        DataTable(
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
                'Poin Kontribusi',
                textAlign: TextAlign.center,
                style: AppTextStyle.s16w700(),
              ),
              onSort: (columnIndex, ascending) {
                debugPrint(columnIndex.toString());
              },
            ),
          ],
          rows: widget.students
              .map((e) => DataRow(cells: [
                    DataCell(Text(e.nis.toString())),
                    DataCell(Text(e.fullname ?? '')),
                    DataCell(Text('${e.contributes ?? 0}')),
                  ]))
              .toList(),
        ),
      ]),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
