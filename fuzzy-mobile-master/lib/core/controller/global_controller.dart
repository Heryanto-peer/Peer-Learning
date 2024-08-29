import 'package:fuzzy_mobile_user/core/controller/user_controller.dart';
import 'package:get/get.dart';

class GlobalController {
  static init() {
    Get.put<UserController>(UserController(), permanent: true);
  }
}
