import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/materi_view/controller/materi_view_controller.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';

class MateriViewScreen extends StatelessWidget {
  const MateriViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MateriViewController>(
      init: MateriViewController(),
      builder: (MateriViewController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.base.tertiary,
            title: Text('Materi', style: AppTextStyle.s18w500(color: AppColors.base.primary)),
            centerTitle: true,
            leadingWidth: 120,
            leading: InkWell(
              onTap: () => Get.back(),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Center(
                    child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: AppColors.base.primary),
                    Text('Selesai', style: AppTextStyle.s14w400(color: AppColors.base.primary)),
                  ],
                )),
              ),
            ),
          ),
          body: controller.loaded ? const Center(child: CircularProgressIndicator()) : PdfViewer.uri(Uri.parse(controller.path)),
        );
      },
    );
  }
}
