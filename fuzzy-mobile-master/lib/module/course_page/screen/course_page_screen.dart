import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_date_format.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/module/course_page/controller/course_page_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CoursePageScreen extends StatelessWidget {
  const CoursePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursePageController>(
      init: CoursePageController(),
      builder: (CoursePageController controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.onRefresh();
          },
          child: SingleChildScrollView(
            child: Container(
              height: Get.height,
              width: Get.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppAssets.classRoom), fit: BoxFit.cover, opacity: 0.08),
              ),
              child: controller.isOpenClassed ? _build(controller) : closedClass(controller),
            ),
          ),
        );
      },
    );
  }

  Widget closedClass(CoursePageController controller) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Gap(Get.height * 0.2),
        Image.asset(
          AppAssets.ilsWaiting,
          height: Get.width * 0.7,
        ),
        Text(
          controller.course == null
              ? 'Kelas belum tersedia\n silahkan tunggu guru anda untuk membuka kelas ini'
              : 'Kelas akan tersedia di jam ${AppDateFormat.formatTime(dateTime: controller.course?.startDate)} s/d ${AppDateFormat.formatTime(dateTime: controller.course?.endDate)}',
          style: AppTextStyle.s16w500(),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _build(CoursePageController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                AppAssets.ilsLearning,
                height: Get.width * 0.5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Course', style: AppTextStyle.s24w700()),
                    const Gap(16),
                    Text(
                        'course adalah kumpulan materi yang diberikan oleh guru dalam satu kelas di jadwal yang ditentukan, selamat belajar\n Kelas akan tersedia di jam ${AppDateFormat.formatTime(dateTime: controller.course?.startDate)} s/d ${AppDateFormat.formatTime(dateTime: controller.course?.endDate)}',
                        style: AppTextStyle.s12w400()),
                    const Gap(16),
                    AppButton(
                      onPressed: () {
                        controller.eventJoinClass();
                      },
                      text: 'Masuk Kelas',
                    ),
                  ],
                ),
              )
            ],
          ),
          const Gap(16),
          Text(
            'Aturan Kelas',
            style: AppTextStyle.s24w700(),
          ),
          const Gap(16),
          Text(
            '1. Siswa hanya dapat mengerjakan soal yang diberikan oleh guru.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '2. Siswa dilarang keluar dari halaman ini selama kelas sedang berlangsung.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '3. Siswa harus mengerjakan pre-quiz terlebih dahulu secara individu, terdiri dari 10 soal acak.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '4. Setelah menyelesaikan pre-quiz, siswa harus berdiskusi berdasarkan materi yang tersedia dalam aplikasi.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '5. Partisipasi dan bantuan yang diberikan kepada rekan akan dinilai oleh rekan satu tim, jadi aktiflah dalam diskusi dan bantu rekan Anda.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '6. Materi diskusi berkaitan dengan soal-soal post-quiz.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '7. Setelah diskusi, siswa harus memberikan penilaian terbaik kepada rekan satu tim berdasarkan keaktifan dan bantuan yang diberikan.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '8. Setelah memberikan penilaian, siswa harus menyelesaikan post-quiz secara individu, terdiri dari 10 soal acak.',
            style: AppTextStyle.s12w400(),
          ),
          const Gap(8),
          Text(
            '9. Kelas selesai.',
            style: AppTextStyle.s12w400(),
          ),
        ],
      ),
    );
  }
}
