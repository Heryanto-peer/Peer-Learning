import 'package:dio/dio.dart';
import 'package:fuzzy_web_admin/common/model/response_default_model.dart';
import 'package:fuzzy_web_admin/core/network/app_network.dart';

class LoginNetwork{

  Future<ResponseDefaultModel> postLogin({required Map<String, dynamic> data}) async {
    try {
      final FormData formData = FormData.fromMap(data);
      final res = await AppNetworkClient.post(path: '/teacher/login', form: formData);
      return ResponseDefaultModel.fromJson(res.data);
    } catch (e) {
      rethrow;
    }
  }
}