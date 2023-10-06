import 'dart:io';

import 'package:blue_real_estate/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    Map<String, String> headers = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(SPConstants.token) != null) {
      headers.addAll({
        "Token": prefs.getString(SPConstants.token).toString(),
      });
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    headers.addAll({"Version": packageInfo.version});

    options.connectTimeout = 500000;
    options.responseType = ResponseType.json;
    options.contentType = ContentType.json.toString();
    options.headers = headers;

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // debugPrint(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // debugPrint(
    //     'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
