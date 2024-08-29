import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy_web_admin/core/controller/global_controller.dart';
import 'package:fuzzy_web_admin/core/route/app_route.dart';
import 'package:fuzzy_web_admin/core/route/route_constant.dart';
import 'package:fuzzy_web_admin/core/store/app_store.dart';
import 'package:fuzzy_web_admin/core/style/app_theme.dart';
import 'package:fuzzy_web_admin/firebase_options.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id');
  GlobalController.init;
  AppStore.instance.storage;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoute.all,
      initialRoute: RouteConstant.login,
      locale: const Locale('id', 'ID'),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      defaultTransition: Transition.native,
    );
  }
}
