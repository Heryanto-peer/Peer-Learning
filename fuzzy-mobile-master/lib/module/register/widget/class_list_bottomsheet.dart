import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClassListBottomSheet {
  static Future<ClassModel> show({required List<ClassModel> kelasModel}) async {
    return await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _MateriBottomsheet(
          kelasModel: kelasModel,
        );
      },
    );
  }
}

class _MateriBottomsheet extends StatefulWidget {
  final List<ClassModel> kelasModel;

  const _MateriBottomsheet({required this.kelasModel});

  @override
  State<_MateriBottomsheet> createState() => _MateriBottomsheetState();
}

class _MateriBottomsheetState extends State<_MateriBottomsheet> {
  ClassModel? selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.kelasModel.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.base.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: AppTextStyle.s14w500(),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        widget.kelasModel[index].className ?? '',
                        style: AppTextStyle.s14w500(),
                      ),
                    ),
                    const Gap(10),
                    IconButton(
                      onPressed: () {
                        if (selected?.classId == widget.kelasModel[index].classId) {
                          setState(() {
                            selected = null;
                          });
                        } else {
                          setState(() {
                            selected = widget.kelasModel[index];
                          });
                        }
                      },
                      icon: Icon(
                        selected?.classId == widget.kelasModel[index].classId ? Icons.check_box : Icons.check_box_outline_blank,
                        color: AppColors.base.primary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Gap(20),
          SizedBox(
            width: Get.width * 0.2,
            child: AppButton(
              text: 'Pilih',
              onPressed: () {
                Get.back(result: selected);
              },
            ),
          ),
        ],
      ),
    );
  }
}
