import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/module/assesment/screen/assesment_screen.dart';
import 'package:fuzzy_mobile_user/module/home/screen/home_screen.dart';
import 'package:fuzzy_mobile_user/module/login/screen/login_screen.dart';
import 'package:fuzzy_mobile_user/module/materi_view/screen/materi_view_screen.dart';
import 'package:fuzzy_mobile_user/module/quiz/challenge_quiz/screen/challenge_quiz_screen.dart';
import 'package:fuzzy_mobile_user/module/quiz/prepare_quiz/screen/prepare_quiz_screen.dart';
import 'package:fuzzy_mobile_user/module/quiz/result_quiz/screen/result_quiz_screen.dart';
import 'package:fuzzy_mobile_user/module/register/screen/register_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final all = [
    GetPage(name: RouteConstant.login, page: () => const LoginScreen()),
    GetPage(name: RouteConstant.register, page: () => const RegisterScreen()),
    GetPage(name: RouteConstant.home, page: () => const HomeScreen()),
    GetPage(name: RouteConstant.prepareQuiz, page: () => const PrepareQuizScreen()),
    GetPage(name: RouteConstant.challengeQuiz, page: () => const ChallengeQuizScreen()),
    GetPage(name: RouteConstant.resultQuiz, page: () => const ResultQuizScreen()),
    GetPage(name: RouteConstant.assesment, page: () => const AssesmentScreen()),
    GetPage(name: RouteConstant.materiView, page: () => const MateriViewScreen()),
  ];
}
