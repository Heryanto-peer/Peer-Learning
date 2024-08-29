import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/profile/controller/profile_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (ProfileController controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: Get.height * 0.3,
                    width: Get.width,
                    padding: const EdgeInsets.only(top: 16, bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.base.lightBlue,
                    ),
                  ),
                  Container(
                    height: Get.height * 0.15,
                    width: Get.width,
                    padding: const EdgeInsets.only(top: 16, bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColors.base.primary,
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.15 - 50,
                    left: Get.width * 0.2,
                    right: Get.width * 0.2,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.base.lightBlue,
                          foregroundImage: controller.siswa?.imageProfile == null ? const AssetImage(AppAssets.userHolder) : NetworkImage(controller.siswa!.imageProfile!) as ImageProvider,
                        ),
                        Text(
                          controller.siswa?.fullname ?? '',
                          style: AppTextStyle.s14w700(color: AppColors.base.tertiary),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: InkWell(
                        onTap: () {
                          controller.eventLogout();
                        },
                        child: Text('Logout', style: AppTextStyle.s14w700(color: AppColors.base.grey))),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: InkWell(
                        onTap: () {
                          controller.eventLogout();
                        },
                        child: Text(controller.version, style: AppTextStyle.s14w700(color: AppColors.base.grey))),
                  ),
                ],
              ),
              const Gap(16),
              Center(child: Text(controller.siswa?.group?.groupName ?? '', style: AppTextStyle.s16w700(color: AppColors.base.primary))),
              const Gap(8),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: DataTable(
                    border: TableBorder(
                      horizontalInside: BorderSide(
                        color: AppColors.base.grey,
                        width: 1,
                      ),
                    ),
                    headingRowColor: WidgetStatePropertyAll(AppColors.base.tertiary),
                    columns: [
                      DataColumn(
                          label: Text(
                        'NIS',
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
                          'Poin',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.s14w700(),
                        ),
                      ),
                    ],
                    rows: controller.teamMates
                        .map((e) => DataRow(cells: [
                              DataCell(Text('${e.nis}')),
                              DataCell(Text(e.fullname ?? '')),
                              DataCell(Text('${e.contributes ?? 0}')),
                            ]))
                        .toList(),
                  ),
                ),
              ),
              const Gap(16),
              Gap(Get.height * 0.2),
            ],
          ),
        );
      },
    );
  }
}
