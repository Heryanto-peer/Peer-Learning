import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/module/course_page/screen/course_page_screen.dart';
import 'package:fuzzy_mobile_user/module/home/data/repo/home_repo.dart';
import 'package:fuzzy_mobile_user/module/homepage/screen/homepage_screen.dart';
import 'package:fuzzy_mobile_user/module/materi_page/screen/materi_page_screen.dart';
import 'package:fuzzy_mobile_user/module/profile/screen/profile_screen.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with HomeRepo {
  int stage = 0;

  Widget build = const HomepageScreen();

  set setStage(int value) {
    stage = value;
    _switchBuild();
  }

  _switchBuild() {
    switch (stage) {
      case 1:
        build = const MateriPageScreen();
        break;

      case 2:
        build = const CoursePageScreen();
        break;

      case 3:
        build = const ProfileScreen();
        break;
      default:
        build = const HomepageScreen();
        break;
    }

    update();
  }
}
