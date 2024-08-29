import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/style/app_colors.dart';
import 'package:fuzzy_web_admin/core/style/app_text_style.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/model/materi_model.dart';
import 'package:fuzzy_web_admin/module/homes/materi/data/network/materi_network.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MateriBottomsheet {
  static Future<bool> show({required List<MaterisModel> materisModel, required String subjectID}) async {
    return await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _MateriBottomsheet(
          materisModel: materisModel,
          subjectID: subjectID,
        );
      },
    );
  }
}

class _MateriBottomsheet extends StatelessWidget {
  final List<MaterisModel> materisModel;
  final String subjectID;
  const _MateriBottomsheet({required this.materisModel, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: materisModel.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.back(result: materisModel[index]);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  openFile(materisModel[index].pathMateri!);
                },
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white.primary,
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
                        materisModel[index].materiName!,
                        style: AppTextStyle.s14w500(),
                      ),
                    ),
                    const Gap(10),
                    IconButton(
                      onPressed: () {
                        removeMateri(index);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.red.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// open file in browser
  openFile(String url) async {
    url = 'http://$url';
    if (await canLaunchUrlString(url)) {
      debugPrint('Launching $url');
      await launchUrlString(
        url,
        webOnlyWindowName: '_blank',
      );
    }

    debugPrint('Could not launch $url');
  }

  /// remove materi
  removeMateri(int index) async {
    try {
      final network = MateriNetwork();
      final res = await network.removeMateri(subjectID: subjectID, materiID: materisModel[index].materiId!);
      if (res.status == 200) {
        /// set for refresh data
        Get.back(result: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
