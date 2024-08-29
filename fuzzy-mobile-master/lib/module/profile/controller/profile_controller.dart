import 'package:fuzzy_mobile_user/common/model/siswa_model.dart';
import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/core/store/app_store.dart';
import 'package:fuzzy_mobile_user/module/profile/data/repo/profile_repo.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController with ProfileRepo {
  SiswaModel? siswa;
  List<SiswaModel> teamMates = [];
  String version = 'v.';

  eventLogout() async {
    await AppStore.instance.setSiswa(null);
    Get.offAllNamed(RouteConstant.login);
  }

  fetchteamMember() async {
    siswa = await AppStore.instance.siswa;
    update();
    if (siswa?.datumClass?.classId == null) return;
    final res = await repoGetGroupByClassId(groupID: siswa!.group!.groupId!);
    if (res.listStudent?.isNotEmpty != true) return;
    teamMates = res.listStudent!;
    teamMates.sort((a, b) => (b.contributes ?? 0).compareTo((a.contributes ?? 0)));
    update();
  }

  @override
  void onInit() async {
    final info = await PackageInfo.fromPlatform();
    version = 'v. ${info.version} (${info.buildNumber})';
    update();
    fetchteamMember();
    super.onInit();
  }
}
