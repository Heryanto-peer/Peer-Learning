import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/utils/app_textstyle.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/assesment/controller/assesment_controller.dart';
import 'package:gap/gap.dart';

class CardPerson extends StatelessWidget {
  final int index;
  final AssesmentController controller;
  const CardPerson({
    super.key,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(children: [
              itemBuild(title: 'Nama', value: controller.assesmentData?.assesments?[index].fullname ?? ''),
              Row(
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.base.primary,
                      ),
                      child: Column(
                        children: [
                          Text('Rating Keaktifan', style: AppTextStyle.s12w500(color: AppColors.base.tertiary)),
                          FittedBox(
                            child: RatingBar(
                              filledIcon: Icons.star,
                              halfFilledIcon: Icons.star_half,
                              emptyIcon: Icons.star,
                              onRatingChanged: (value) {
                                controller.eventChangeKeaktifan(value: value.toInt(), index: index);
                              },
                              isHalfAllowed: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(10),
                  Flexible(
                    child: Column(
                      children: [
                        Text('Rating Bantuan', style: AppTextStyle.s12w500()),
                        FittedBox(
                            child: RatingBar(
                          filledIcon: Icons.star,
                          halfFilledIcon: Icons.star_half,
                          emptyIcon: Icons.star,
                          onRatingChanged: (value) {
                            controller.eventChangeBantuan(value: value.toInt(), index: index);
                          },
                          isHalfAllowed: false,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget itemBuild({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Row(
        children: [
          Flexible(child: Text(title, style: AppTextStyle.s12w500())),
          const Gap(10),
          Flexible(flex: 2, child: Text(value, style: AppTextStyle.s12w400(color: AppColors.base.primary))),
        ],
      ),
    );
  }
}
