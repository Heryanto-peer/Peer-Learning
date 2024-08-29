import 'package:fuzzy_mobile_user/core/route/route_constant.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/model/materi_model.dart';
import 'package:fuzzy_mobile_user/module/materi_page/data/repo/materi_page_repo.dart';
import 'package:get/get.dart';

class MateriPageController extends GetxController with MateriPageRepo {
  List<MateriModel> materiList = [];

  getRepoMateri() async {
    materiList = await repoGetAllMateri();
    update();
  }

  @override
  void onInit() {
    getRepoMateri();
    super.onInit();
  }

  openFile(String url) async {
    url = 'http://$url';
    Get.toNamed(RouteConstant.materiView, arguments: url);
    // if (await canLaunchUrlString(url)) {
    //   debugPrint('Launching $url');
    //   await launchUrlString(url, mode: LaunchMode.inAppBrowserView);
    // }

    // debugPrint('Could not launch $url');
  }
}
