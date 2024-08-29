import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  void initConfig() async {
    // final config = RemoteConfigSettings(
    //   fetchTimeout: const Duration(seconds: 10),
    //   minimumFetchInterval: const Duration(seconds: 5),
    // );
    // _remoteConfig.setConfigSettings(config);
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void onInit() {
    initConfig();
    super.onInit();
  }
}
