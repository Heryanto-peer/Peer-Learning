import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/module/homes/kelas/screen/kelas_screen.dart';
import 'package:fuzzy_web_admin/module/homes/materi/screen/materi_screen.dart';
import 'package:fuzzy_web_admin/module/homes/quiz/screen/quiz_screen.dart';
import 'package:fuzzy_web_admin/module/login/screen/login_screen.dart';
import 'package:get/get.dart';

class AppRoute {
  static List<GetPage> all = [
    GetPage(name: RouteConstant.home, page: () => const KelasScreen()),
    GetPage(name: RouteConstant.quiz, page: () => const QuizScreen()),
    GetPage(name: RouteConstant.materi, page: () => const MateriScreen()),
    GetPage(name: RouteConstant.login, page: () => const LoginScreen()),
  ];
}
