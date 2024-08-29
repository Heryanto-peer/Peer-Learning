import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_mobile_user/core/controller/global_controller.dart';
import 'package:fuzzy_mobile_user/core/route/app_route.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/core/style/app_theme.dart';
import 'package:fuzzy_mobile_user/firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('id');
  AppStore.instance.storage;
  GlobalController.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.all,
      initialRoute: RouteConstant.login,
      locale: const Locale('id', 'ID'),
      theme: AppTheme.lightTheme,
      defaultTransition: Transition.native,
    );
  }
}
