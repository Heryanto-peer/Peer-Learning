import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/data/model/group_model.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class Leaderboard extends StatefulWidget {
  final List<GroupModel> listGroup;
  const Leaderboard({super.key, required this.listGroup});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: Get.width * 0.7,
        width: Get.width * 0.5,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('LeaderBoard', style: AppTextStyle.s24w800(), textAlign: TextAlign.center),
            const Gap(16),
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
                    'Peringkat',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.s14w700(),
                  )),
                  DataColumn(
                    label: Text(
                      'Nama',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.s14w700(),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total Poin',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.s14w700(),
                    ),
                  ),
                ],
                rows: List.generate(widget.listGroup.length, (index) {
                  return DataRow(cells: [
                    DataCell(Text('${index + 1}')),
                    DataCell(Text(widget.listGroup[index].groupName ?? '')),
                    DataCell(Text('${widget.listGroup[index].totalPoin ?? 0}')),
                  ]);
                })),
          ],
        ),
      ),
    );
  }
}
