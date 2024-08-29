//Example of Repo
//You might not use it
import 'package:flutter/foundation.dart';
import 'package:fuzzy_mobile_user/common/model/course_active_model.dart';
import 'package:fuzzy_mobile_user/module/course_page/data/network/course_network.dart';

mixin CoursePageRepo {
  final _myNetwork = CourseNetwork();

  Future<CourseModel?> repoGetCourse() async {
    try {
      final res = await _myNetwork.getCourse();
      return CourseModel.fromMap(res.data);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
