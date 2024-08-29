import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/common/assets/app_assets.dart';
import 'package:fuzzy_mobile_user/core/style/app_colors.dart';
import 'package:fuzzy_mobile_user/module/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              controller.build,
              SafeArea(
                child: SizedBox(
                  height: 120,
                  child: DotNavigationBar(
                    margin: EdgeInsets.zero,
                    curve: Curves.decelerate,
                    backgroundColor: AppColors.base.primary,
                    items: [
                      DotNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.iconHome,
                          width: 20,
                          height: 20,
                          color: controller.stage == 0 ? AppColors.base.tertiary : AppColors.base.grey,
                        ),
                      ),
                      DotNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.iconCourse,
                          width: 20,
                          height: 20,
                          color: controller.stage == 1 ? AppColors.base.tertiary : AppColors.base.grey,
                        ),
                      ),
                      DotNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.iconChallenge,
                          width: 20,
                          height: 20,
                          color: controller.stage == 2 ? AppColors.base.tertiary : AppColors.base.grey,
                        ),
                      ),
                      DotNavigationBarItem(
                        icon: Image.asset(
                          AppAssets.iconProfile,
                          width: 20,
                          height: 20,
                          color: controller.stage == 3 ? AppColors.base.tertiary : AppColors.base.grey,
                        ),
                      ),
                    ],
                    currentIndex: controller.stage,
                    dotIndicatorColor: AppColors.base.tertiary,
                    onTap: (int index) {
                      controller.setStage = index;
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
