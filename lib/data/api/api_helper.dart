import 'package:flutter/foundation.dart';
import 'package:wiwalk_app/core/utils/func.dart';
import 'package:wiwalk_app/core/utils/shared_pref.dart';

class ApiHelper {
  static String get baseUrl => kDebugMode ? _baseUrlDev : _baseUrlProd;
  static const String _baseUrlProd = 'http://103.143.40.233:8063';
  static const String _baseUrlDev = 'http://103.143.40.233:8063';

  static String get clientId => kDebugMode ? _clientIdDev : _clientIdProd;
  static const String _clientIdProd = 'Walk';
  static const String _clientIdDev = 'Walk';

  static String get clientSecret =>
      kDebugMode ? _clientSecretDev : _clientSecretProd;
  static const String _clientSecretProd = 'Walk1!';
  static const String _clientSecretDev = 'Walk1!';

  static Map<String, String> getHttpHeaders({
    AuthType authType = AuthType.bearerToken,
    String? contentType,
  }) {
    var headers = <String, String>{};
    headers.addAll({
      'Connection': 'keep-alive',
      'Accept-Charset': 'utf-8',
      'Content-Type': contentType ?? 'application/json',
    });

    String? accessToken = sharedPref.getString(SharedPrefKeys.accessToken);
    if (authType == AuthType.bearerToken && Func.isNotEmpty(accessToken)) {
      headers.addAll({'authorization': 'Bearer $accessToken'});
    }

    return headers;
  }
}

enum HttpMethod { get, post, delete, put }

enum AuthType {
  noAuth,
  apiKey,
  basicAuth,
  bearerToken,
  oAuth1,
  oAuth2,
  awsSignature,
}

/// HTTP status code
class StatusCode {
  // 1xx Informational
  static const cont = 100;

  // 2xx Success
  static const ok = 200;
  static const created = 201;

  // 3xx Redirection
  static const multipleChoices = 300;

  // 4xx Client error
  static const failed = 400000; // Failed
  static const badRequest = 400; // No internet
  static const unauthorized = 401; // We could not recognize you.
  static const forbidden =
      403; // Access to the requested resource or action is forbidden.
  static const notFound = 404; // The requested resource could not be found.
  static const requestTimeout = 408; // Request Timeout
  static const unprocessableContent =
      422; // unable to process the contained instructions

  // 5xx Server error
  static const internalServerError =
      500; // We had a problem with our server. Try again later.
  static const serviceUnavailable =
      503; // We're temporarily offline for maintenance. Please try again later.

  // Business response codes
  static const serializeError = 999; // json serializeError

  // https://docs.oracle.com/cd/E25294_01/doc.920/e15484/oltappxa.htm
  static const disconnected = 12163; // The Internet connection has been lost.
}
