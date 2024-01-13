import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioLoggingInterceptor extends Interceptor {
  DioLoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    debugPrint('<-- HTTP ${options.method} Request');

    printLog('Uri', options.uri);
    debugPrint('Headers:');
    options.headers.forEach((key, v) => printLog(' - $key', v));
    printLog('Body', options.data ?? "");

    debugPrint('--> END HTTP ${options.method} Request');
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    debugPrint('<-- HTTP Error');

    debugPrint('Uri: ${err.requestOptions.uri}');
    if (err.response != null) {
      debugPrint('Status code: ${err.response?.statusCode.toString()}');
    }
    printLog('Error', err.error ?? '');

    if (err.message != null) {
      printLog('Message', err.message ?? '');
    }

    debugPrint('--> END HTTP Error');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    debugPrint('<-- HTTP Response');

    printLog('Uri', response.realUri);
    printLog('Status code', response.statusCode ?? -1);
    printLog('Redirect', response.isRedirect);
    printLog('Body', response.data ?? "");

    debugPrint('--> END HTTP Response');
  }

  void printLog(String key, Object v) {
    debugPrint('$key: $v');
  }
}
