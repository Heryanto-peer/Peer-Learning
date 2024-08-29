import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppNetworkClient {
  static final _logNetworking = PrettyDioLogger(
    compact: true,
    error: true,
  );
  static final Dio _dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 10000), receiveTimeout: const Duration(seconds: 3000), contentType: 'application/json'))
    ..interceptors.add(_logNetworking);

  static String? baseurl = 'https://fuzzyweb.work.gd/sugar'; // 'http://38.9.141.145:8080'; // 'http://localhost:8080'; //

  static final AppNetworkClient _instance = AppNetworkClient._();

  factory AppNetworkClient() {
    return _instance;
  }

  AppNetworkClient._();

  static Future<Response> delete({
    String? url,
    Map<String, dynamic>? customHeader,
    required String path,
    FormData? form,
    // jsonMap for sending raw json to server
    Map<String, dynamic>? jsonMap,
  }) async {
    try {
      final res = await _dio.delete((url ?? baseurl)! + path, data: form ?? jsonMap);
      return res;
    } on DioException catch (e) {
      _errorCatch(e);
      try {
        throw '[${e.response!.statusCode}] Server Error, try again later';
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw 'Something Went Wrong';
    }
  }

  static Future<Response> get({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? jsonMap,
    String? url,
    Map<String, dynamic>? customHeader,
    FormData? form,
    required String path,
  }) async {
    try {
      final res = await _dio.get((url ?? baseurl)! + path, queryParameters: queryParameters, data: form ?? jsonMap);

      debugPrint('CALLING GET ${res.requestOptions.path}');
      debugPrint('Query GET ${res.requestOptions.queryParameters}');

      // debugPrint("Data Response " + res.data.toString());

      return res;
    } on DioException catch (e) {
      _errorCatch(e);
      try {
        throw '[500] Server Error, try again later';
      } catch (e) {
        throw e.toString();
      }
    } catch (e) {
      throw 'Something Went Wrong';
    }
  }

  static Future<Response> post(
      {Map<String, dynamic>? data,
      String? url,
      Map<String, dynamic>? customHeader,
      required String path,
      FormData? form,
      // jsonMap for sending raw json to server
      Map<String, dynamic>? jsonMap,
      dynamic dataDynamic}) async {
    try {
      final res = await _dio.post(
        (url ?? baseurl)! + path,
        data: form ?? jsonMap ?? dataDynamic ?? FormData.fromMap(data!),
      );

      debugPrint('CALLING POST ${res.requestOptions.path}');
      // debugPrint("Response Data " + res.data.toString());

      return res;
    } on DioException catch (e) {
      _errorCatch(e);
      try {
        throw '[${e.response!.statusCode}] Server Error, try again later';
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      throw 'Something Went Wrong';
    }
  }

  static Future<Response> put({
    Map<String, dynamic>? data,
    String? url,
    Map<String, dynamic>? customHeader,
    required String path,
    FormData? form,
    // jsonMap for sending raw json to server
    Map<String, dynamic>? jsonMap,
  }) async {
    try {
      final res = await _dio.put((url ?? baseurl)! + path, data: form ?? jsonMap ?? FormData.fromMap(data!));

      debugPrint('CALLING PUT ${res.requestOptions.path}');
      // debugPrint("Response Data " + res.data.toString());

      return res;
    } on DioException catch (e) {
      _errorCatch(e);
      try {
        throw '[${e.response!.statusCode}] Server Error, try again later';
      } catch (e) {
        rethrow;
      }
    } catch (e) {
      throw 'Something Went Wrong';
    }
  }

  static void _errorCatch(DioException e) {
    if (e.response != null) {
      debugPrint('Error CALLING ${e.requestOptions.path}');

      debugPrint('Error Status Code ${e.response!.statusCode}');
      debugPrint('Error Response ${e.response!.data}');
    } else {
      // Something happened in setting up or sending the requestOptions that triggered an Error
      debugPrint('CALLING ${e.requestOptions}');
      debugPrint(e.message);
    }
  }
}
