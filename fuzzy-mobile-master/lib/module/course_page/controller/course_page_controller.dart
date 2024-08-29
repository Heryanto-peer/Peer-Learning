import 'package:fuzzy_mobile_user/common/model/course_active_model.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/module/course_page/data/repo/course_page_repo.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/data/utils/quiz_type_enum.dart';
import 'package:get/get.dart';

class CoursePageController extends GetxController with CoursePageRepo {
  bool isOpenClassed = false;
  CourseModel? course;

  eventJoinClass() async {
    await Get.toNamed(RouteConstant.prepareQuiz, arguments: {'type': QuizTypeEnum.preQuiz, 'subjectId': course?.subjectId});
  }

  @override
  void onInit() {
    _fetchCourseInfo();

    super.onInit();
  }

  onRefresh() {
    _fetchCourseInfo();
  }

  _fetchCourseInfo() async {
    course = await repoGetCourse();

    isOpenClassed = false;
    update();
    if (course == null) {
      return;
    }

    if (course?.subjectId != null) {
      final now = DateTime.now();

      if (now.isAfter(course!.startDate!) && now.isBefore(course!.endDate!)) {
        isOpenClassed = true;
      }
    }
    update();
  }
}
