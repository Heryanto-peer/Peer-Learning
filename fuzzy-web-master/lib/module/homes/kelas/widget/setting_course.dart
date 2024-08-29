import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/model/materi_model.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingCourse extends StatefulWidget {
  final List<MateriModel> materi;
  const SettingCourse({
    super.key,
    required this.materi,
  });

  @override
  State<SettingCourse> createState() => _GroupLeaderboardState();
}

class _GroupLeaderboardState extends State<SettingCourse> {
  MateriModel? selectedMateri;
  String? startTime;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Setting Course', style: AppTextStyle.s18w700()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(10),
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
                'Materi Pembelajaran',
                textAlign: TextAlign.center,
                style: AppTextStyle.s16w700(),
              )),
              DataColumn(
                label: Text(
                  'Nama Guru',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.s16w700(),
                ),
                onSort: (columnIndex, ascending) {
                  debugPrint(columnIndex.toString());
                },
              ),
              DataColumn(
                label: Text(
                  'Actived Course',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.s16w700(),
                ),
                onSort: (columnIndex, ascending) {
                  debugPrint(columnIndex.toString());
                },
              ),
            ],
            rows: widget.materi
                .map((e) => DataRow(cells: [
                      DataCell(Text(e.subjectName.toString())),
                      DataCell(Text(e.teacherName ?? '')),
                      DataCell(
                          Container(
                              height: 20,
                              width: 20,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(border: Border.all(color: AppColors.blue.primary), shape: BoxShape.circle),
                              child: selectedMateri?.subjectId == e.subjectId
                                  ? Icon(
                                      Icons.circle,
                                      color: AppColors.blue.primary,
                                      size: 12,
                                    )
                                  : null), onTap: () {
                        setState(() {
                          selectedMateri = e;
                        });
                      }),
                    ]))
                .toList(),
          ),
          const Gap(10),
          Text('Pilih waktu mulai course', style: AppTextStyle.s16w700()),
          const Gap(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    eventStartTime();
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey.primary),
                    ),
                    child: Row(
                      children: [Icon(Icons.timelapse, color: AppColors.blue.primary), const Gap(10), Text(startTime ?? 'Mulai', style: AppTextStyle.s16w700())],
                    ),
                  ),
                ),
                const Gap(10),
                Container(
                  width: 5,
                  height: 2,
                  color: AppColors.black.primary,
                ),
                const Gap(10),
                InkWell(
                  onTap: () async {
                    eventEndTime();
                  },
                  child: Container(
                    width: 150,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey.primary),
                    ),
                    child: Row(
                      children: [Icon(Icons.timelapse, color: AppColors.blue.primary), const Gap(10), Text(endTime ?? 'Akhir', style: AppTextStyle.s16w700())],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Keluar'),
        ),
        TextButton(
          onPressed: () => Get.back(result: {'subject_id': selectedMateri?.subjectId, 'start_course': startTime, 'end_course': endTime}),
          child: const Text('Pilih'),
        ),
      ],
    );
  }

  eventEndTime() async {
    await Navigator.of(context).push(showPicker(
        value: Time(hour: 14, minute: 00),
        sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
        sunset: const TimeOfDay(hour: 18, minute: 0), // optional
        duskSpanInMinutes: 120,
        onChange: (time) {
          setState(() {
            endTime = '${time.hour}:${time.minute}:${time.second}';
          });
        }));
  }

  eventStartTime() async {
    await Navigator.of(context).push(showPicker(
        value: Time(hour: 10, minute: 00, second: 00),
        sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
        sunset: const TimeOfDay(hour: 18, minute: 0), // optional
        duskSpanInMinutes: 120,
        onChange: (time) {
          setState(() {
            startTime = '${time.hour}:${time.minute}:${time.second}';
          });
        }));
  }
}
