import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/module/homes/siswa/data/model/siswa_model.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RemoveUser extends StatelessWidget {
  final SiswaModel siswa;
  const RemoveUser({super.key, required this.siswa});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Anda yakin ingin menghapus ${siswa.fullname}?'),
          const Gap(20),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.red.error, foregroundColor: AppColors.white.text),
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: const Text('Tidak'),
                ),
              ),
              const Gap(20),
              Expanded(
                child: TextButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.green.success, foregroundColor: AppColors.white.text),
                  onPressed: () {
                    Get.back(result: true);
                  },
                  child: const Text('Ya'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
