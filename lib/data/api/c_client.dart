import 'dart:async';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:wiwalk_app/core/utils/logger.dart';
import 'package:wiwalk_app/data/models/c_response.dart';
import 'api_helper.dart';

part 'api_paths.dart';

/// Global api caller
CClient cClient = CClient();

class CClient {
  Dio _client = Dio();

  CClient() {
    init(url: ApiHelper.baseUrl, isInit: true);
  }

  /// Main HTTP request
  Future<Response> sendRequest({
    String? url,
    required String path,
    HttpMethod httpMethod = HttpMethod.post,
    Map<String, String>? headers,
    AuthType authType = AuthType.bearerToken,
    dynamic requestData,
    String? contentType,
  }) async {
    // Headers
    headers ??= ApiHelper.getHttpHeaders(
      authType: authType,
      contentType: contentType,
    );
    _client.options.headers = headers;
    _client.options.baseUrl = url ?? ApiHelper.baseUrl;
    if (authType != AuthType.bearerToken) {
      _client.options.headers.remove("Authorization");
    }

    try {
      // Send request
      logger.i('func: $path, $httpMethod, step: 2, requestData: $requestData');
      switch (httpMethod) {
        case HttpMethod.get:
          return await _client.get(path);
        case HttpMethod.put:
          return await _client.put(path, data: requestData);
        case HttpMethod.delete:
          return await _client.delete(path, data: requestData);
        case HttpMethod.post:
        default:
          return await _client.post(path, data: requestData);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
        // print(e.response?.data?["Message"]);
        // print(e.response?.headers);
        // print(e.response?.requestOptions);
      } else {
        return Response(
          requestOptions: RequestOptions(path: path),
          data: CResponse(
            responseDate: null,
            retType: 1,
            retDesc: 'Амжилтгүй',
          ),
        );
        // print(e.requestOptions);
        // print(e.message);
      }
    }
  }

  void init({
    required String url,
    bool isInit = false, // URL өөрчлөгдсөн бол client-ийг дахин тодорхойлно
  }) async {
    /// Main http client
    logger.i('func: Api init, step: 1');

    BaseOptions options = BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 60),
    );
    options.baseUrl = ApiHelper.baseUrl;
    options.contentType = Headers.jsonContentType;
    options.headers = ApiHelper.getHttpHeaders();

    _client = Dio(options);
    _client.interceptors.add(CookieManager(CookieJar()));
    if (kDebugMode) {
      _client.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    // Дараах алдааг засав
    //I/flutter (29083): DioError [DioErrorType.DEFAULT]: HandshakeException: Handshake error in client (OS Error:
    //I/flutter (29083): 	CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate(handshake.cc:354))
    // (_client.httpClientAdapter as IOHttpClientAdapter).createHttpClient =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
  }

// Future postFormData({required String path, required File file}) async {
//   var res = <String, dynamic>{}
//     ..putIfAbsent(ApiDataFields.statusCode, () => null)
//     ..putIfAbsent(ApiDataFields.message, () => null)
//     ..putIfAbsent(ApiDataFields.data, () => null);
//
//   try {
//     // await _refreshAccessToken(AuthType.bearerToken);
//
//     _client.options.headers = ApiHelper.getHttpHeaders(
//         contentType: Headers.formUrlEncodedContentType);
//     FormData formData = FormData.fromMap({
//       'photo': await MultipartFile.fromFile(file.path, filename: 'image.jpg'),
//     });
//
//     final httpResponse = await _client.post(path, data: formData);
//
//     res[ApiDataFields.statusCode] = httpResponse.statusCode;
//     if (httpResponse.data != null &&
//         httpResponse.data is Map<String, dynamic>) {
//       res.addAll(httpResponse.data[ApiDataFields.data]);
//     }
//   } on DioError catch (e) {
//     res[ApiDataFields.statusCode] = e.response!.statusCode;
//     res[ApiDataFields.message] = e.response!.data?[ApiDataFields.message];
//   } catch (e) {
//     logger.f(e);
//     res[ApiDataFields.statusCode] = StatusCode.failed;
//     res[ApiDataFields.message] = 'Амжилтгүй';
//   }
//
//   return res;
// }

// Future<void> _refreshAccessToken(AuthType authType) async {
//   Logger.log('test');
//
//   try {
//     if (authType == AuthType.bearerToken) {
//       if (globals.accessTokenExpireTime != null && globals.accessTokenExpireTime!.isBefore(DateTime.now())) {
//         Logger.log('Token is inactive');
//
//         var refreshToken = SharedPref.getRefreshToken();
//         if (Utils.isNotEmpty(refreshToken)) {
//           var options = BaseOptions()..headers = ApiHelper.getHttpHeaders();
//           Dio dio = Dio(options);
//           (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
//             client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
//             return client;
//           };
//
//           var refreshTokenRequest = RefreshTokenRequest(refreshToken: refreshToken);
//           var httpResponse = await dio.post(
//             ApiHelper.baseUrl + HttpPaths.refreshToken,
//             data: refreshTokenRequest.toJson(),
//           );
//
//           if (httpResponse.statusCode == StatusCode.ok) {
//             var refreshTokenResponse = RefreshTokenResponse.fromJson(httpResponse.data);
//             SharedPref.setAccessToken(refreshTokenResponse.accessToken);
//             SharedPref.setAccessTokenExpireTime(refreshTokenResponse.expiresIn);
//             SharedPref.setRefreshToken(refreshTokenResponse.refreshToken);
//           } else if (httpResponse.statusCode == StatusCode.unprocessable) {
//             Logger.log(LocaleKeys.refreshTokenExpired);
//           }
//         }
//       } else {
//         Logger.log('Token is active');
//       }
//     }
//   } on DioError catch (e) {
//     Logger.log(e);
//   } catch (e) {
//     Logger.log(e);
//   }
// }
}

// class CustomInterceptors extends Interceptor {
//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     Logger.log('REQUEST[${options.method}] => PATH: ${options.path}');
//     return super.onRequest(options, handler);
//   }
//   @override
//   Future<void> onResponse(Response response, ResponseInterceptorHandler handler) {
//     Logger.log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
//     return super.onResponse(response, handler);
//   }
//   @override
//   Future onError(DioError err, ErrorInterceptorHandler handler) {
//     Logger.log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
//     return super.onError(err, handler);
//   }
// }
