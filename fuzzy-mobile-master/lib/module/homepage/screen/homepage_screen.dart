import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_date_format.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/homepage/controller/homepage_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
      init: HomepageController(),
      builder: (HomepageController controller) {
        return SafeArea(
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                controller.eventRefresh();
              },
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppAssets.classRoom), fit: BoxFit.cover, opacity: 0.08),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(child: Text('${controller.siswa?.fullname}', style: AppTextStyle.s16w500(color: AppColors.base.primary))),
                          Image.asset(
                            AppAssets.iconPoin,
                            height: 20,
                            width: 20,
                            color: AppColors.base.gold,
                          ),
                          Text(' ${controller.siswa?.contributes ?? 0}', style: AppTextStyle.s16w700()),
                        ],
                      ),
                    ),
                    if (controller.siswa?.group?.groupId?.isNotEmpty == true) ...[
                      const Gap(10),
                      _shortcutDailyQuiz(controller),
                    ],
                    const Gap(36),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.base.lightBlue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                      ),
                      child: Text(
                        'Bergabunglah dengan Tim dan Berikan Kontribusi Terbaik Anda!',
                        style: AppTextStyle.s14w700(color: AppColors.base.tertiary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(8),
                    _shortcutTeam(controller),
                    const Gap(8),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.base.lightBlue.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                      ),
                      child: Text(
                        'Hadiah Spesial Menanti Tim Terbaik dan Kontributor Individu Terbaik!',
                        style: AppTextStyle.s14w700(color: AppColors.base.tertiary),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(36),
                    Text('LeaderBoard', style: AppTextStyle.s24w800(), textAlign: TextAlign.center),
                    const Gap(16),
                    DataTable(
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
                        rows: List.generate(controller.listGroup.length, (index) {
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(controller.listGroup[index].groupName ?? '')),
                            DataCell(Text('${controller.listGroup[index].totalPoin ?? 0}')),
                          ]);
                        })),
                    Gap(Get.height * 0.1)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _shortcutDailyQuiz(HomepageController controller) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.base.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
      ),
      child: Stack(
        children: [
          SizedBox(
            height: 160,
            child: Row(
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    AppAssets.ilsDailyQuiz,
                    fit: BoxFit.cover,
                  ),
                ),
                if (controller.siswa?.latestDaily == AppDateFormat.formatDateToDate(dateTime: DateTime.now()))
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Gap(16),
                        CircleAvatar(
                          backgroundImage: controller.siswa?.imageProfile == null ? const AssetImage(AppAssets.userHolder) : NetworkImage(controller.siswa!.imageProfile!) as ImageProvider,
                          radius: 28,
                        ),
                        const Gap(8),
                        Text('${controller.siswa?.fullname}', style: AppTextStyle.s14w500(), textAlign: TextAlign.center),
                        const Gap(8),
                        Text('Terimakasih Telah Berpartisipasi Dalam Daily Quiz', style: AppTextStyle.s12w400(), textAlign: TextAlign.center),
                        const Gap(16),
                      ],
                    ),
                  )
              ],
            ),
          ),
          if (controller.siswa?.latestDaily != AppDateFormat.formatDateToDate(dateTime: DateTime.now()))
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(24),
                Text('Kamu Belum Mengerjakan Quiz Harian', style: AppTextStyle.s14w400(), textAlign: TextAlign.center),
                const Gap(32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: AppButton(
                    onPressed: () {
                      controller.eventDailyQuiz();
                    },
                    text: 'Mulai Mengerjakan',
                    background: AppColors.base.primary,
                    foreground: AppColors.base.tertiary,
                    radius: 50,
                  ),
                ),
                const Gap(16),
              ],
            ),
        ],
      ),
    );
  }

  Widget _shortcutTeam(HomepageController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.base.lightBlue.withOpacity(0.4),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
      ),
      child: controller.siswa?.group?.groupId?.isNotEmpty == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(16),
                Icon(Icons.group, color: AppColors.base.primary, size: 40),
                Text('Anda Belum Terdaftar Dalam kelompok', style: AppTextStyle.s16w500(), textAlign: TextAlign.center),
                const Gap(8),
                Text('Silahkan tunggu guru mendaftarkanmu ke dalam kelompok', style: AppTextStyle.s14w400(), textAlign: TextAlign.center),
                const Gap(16),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Gap(16),
                Text(controller.siswa?.group?.groupName ?? ' ', style: AppTextStyle.s16w500(), textAlign: TextAlign.center),
                const Gap(8),
                Text('Peringkat ke-${controller.peringkat ?? ''}', style: AppTextStyle.s12w500(), textAlign: TextAlign.center),
                const Gap(16),
              ],
            ),
    );
  }
}
