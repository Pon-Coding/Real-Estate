import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/exceptions/http_response_exception.dart';
import '../main.dart';
import '../models/exception_response.dart';
import '../models/app_config.dart';
import '../providers/app_config_provider.dart';
import '../widgets/show_dialog.dart';
import '../helpers/converters/notification_converter.dart';
import '../models/api_response.dart';
import '../services/custom_interceptors.dart';

enum Method { post, postAsObject, get } // put, delete }

class NetworkService {
  factory NetworkService() => _singleton;
  NetworkService._internal();
  static final NetworkService _singleton = NetworkService._internal();

  Future<ApiResponse> requestAsync(
    String path,
    Method method, {
    Map<String, String>? parameters,
    Map<String, dynamic>? body,
    Object? bodyAsObject,
  }) async {
    Dio dio = onCreatingDio();
    try {
      Response? response;
      switch (method) {
        case Method.get:
          response = await dio.get(path, queryParameters: parameters);
          break;
        case Method.post:
          response =
              await dio.post(path, queryParameters: parameters, data: body);
          break;
        case Method.postAsObject:
          response = await dio.post(path,
              queryParameters: parameters, data: jsonEncode(bodyAsObject));
          break;
        // case Method.put:
        //   break;
        // case Method.delete:
        //   break;
      }
      await onHandleResponse(response);
      return ApiResponse.fromJson(response.data);
    } on HttpResponseException catch (_) {
      rethrow;
    } on TimeoutException catch (_) {
      throw FetchDataException("Connection time out");
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw FetchDataException("Connection time out");
        case DioErrorType.response:
          if (e.response == null) {
            await showMyDialog("Error", NotificationType.error,
                contentList: ["Something went wrong." + e.message.toString()]);
            throw FetchDataException(
                "Something went wrong." + e.message.toString());
          } else {
            await showMyDialog(
              "Error ${e.response!.statusCode}",
              NotificationType.error,
              contentList: [e.response!.statusMessage.toString()],
            );
            switch (e.response!.statusCode) {
              case HttpStatus.badRequest:
                throw BadRequestException(e.response!.statusMessage.toString());
              case HttpStatus.unauthorized:
                throw UnauthorizedException(
                    e.response!.statusMessage.toString());
              case HttpStatus.notFound:
                throw NotFoundException(e.response!.statusMessage.toString());
              case HttpStatus.internalServerError:
                throw InternalServerException(
                    e.response!.statusMessage.toString());
              default:
                throw FetchDataException(e.response!.statusMessage.toString());
            }
          }
        case DioErrorType.cancel:
          break;
        case DioErrorType.other:
          await showMyDialog("Error", NotificationType.error,
              contentList: ["Something went wrong." + e.message.toString()]);
          throw FetchDataException(
              "Something went wrong." + e.message.toString());
      }
      rethrow;
    } on SocketException catch (e) {
      await showMyDialog("Error", NotificationType.error,
          contentList: [e.message]);
      rethrow;
    } catch (e) {
      await showMyDialog("Error", NotificationType.error,
          contentList: ["Something went wrong." + e.toString()]);
      rethrow;
    } finally {
      dio.close();
    }
  }

  Dio onCreatingDio() {
    Dio dio = Dio()..interceptors.add(CustomInterceptors());

    // Handle HandshakeException: CERTIFICATE_VERIFY_FAILED
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return client;
    };

    return dio;
  }

  Future<void> onHandleResponse(Response response) async {
    ApiResponse apiResponse = ApiResponse.fromJson(response.data);

    if (apiResponse.status != HttpStatus.ok) {
      ExceptionResponse exceptionResponse =
          ExceptionResponse.fromJson(apiResponse.data as Map<String, dynamic>);

      if (apiResponse.status == HttpStatus.notFound) {
        await showMyDialog("Oops!", NotificationType.error, contentList: [
          "Something went wrong on route to server.",
          response.realUri.path.toString()
        ]);
      }
      if (apiResponse.status == HttpStatus.upgradeRequired) {
        List<String> messageDetailList = [];
        if (exceptionResponse.message != null &&
            exceptionResponse.message != "") {
          messageDetailList.add(exceptionResponse.message.toString());
        }
        await showMyDialog(
          exceptionResponse.error.toString(),
          NotificationType.notification,
          contentList: messageDetailList,
        );

        AppConfig appConfig = Provider.of<AppConfigProvider>(
                navigatorkey.currentContext!,
                listen: false)
            .config;

        if (Platform.isIOS) {
          launchUrl(Uri.parse(appConfig.appstoreLink.toString()),
              mode: LaunchMode.externalApplication);
        } else if (Platform.isAndroid) {
          launchUrl(Uri.parse(appConfig.playstoreLink.toString()),
              mode: LaunchMode.externalApplication);
        }
      } else {
        List<String> messageDetailList = [];
        if (exceptionResponse.message != null &&
            exceptionResponse.message != "") {
          messageDetailList.add(exceptionResponse.message.toString());
        }
        await showMyDialog(
          exceptionResponse.error.toString(),
          NotificationType.error,
          contentList: messageDetailList,
        );
      }

      throwHttpResponseException(
          apiResponse.status, exceptionResponse.message.toString());
    }
  }
}
