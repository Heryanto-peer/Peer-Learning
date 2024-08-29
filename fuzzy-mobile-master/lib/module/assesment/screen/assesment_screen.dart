import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/common/widget/app_button.dart';
import 'package:fuzzy_mobile_user/module/assesment/controller/assesment_controller.dart';
import 'package:fuzzy_mobile_user/module/assesment/widget/card_person.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AssesmentScreen extends StatelessWidget {
  const AssesmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssesmentController>(
      init: AssesmentController(),
      builder: (AssesmentController controller) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                controller.onInit();
              },
              child: Container(
                height: Get.height,
                width: Get.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppAssets.classRoom), fit: BoxFit.cover, opacity: 0.08),
                ),
                child: ListView(
                  children: [
                    Gap(Get.height * 0.1),
                    Text('Form Assesment ${controller.siswa?.group?.groupName} Kelas ${controller.siswa?.datumClass?.className}', style: AppTextStyle.s24w700(), textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                      child: Text(
                          'Berikan penilainan anda terhadap rekan se-kelompok anda terkait dengan keaktifan serta penyampainan ide dan gagasan terhadap tim di RATING KONTRIBUSI dan RATING BANTUAN',
                          style: AppTextStyle.s14w400()),
                    ),
                    if (controller.assesmentData?.assesments?.isNotEmpty ?? false)
                      ListView.separated(
                          itemBuilder: (_, index) {
                            return CardPerson(index: index, controller: controller);
                          },
                          separatorBuilder: (_, __) => const Gap(16),
                          itemCount: controller.assesmentData?.assesments?.length ?? 0,
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          physics: const NeverScrollableScrollPhysics()),
                    const Gap(36),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                      child: AppButton(
                        onPressed: () {
                          controller.eventSubmitAssesment();
                        },
                        text: 'Kirim',
                      ),
                    ),
                    Gap(Get.height * 0.2),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
