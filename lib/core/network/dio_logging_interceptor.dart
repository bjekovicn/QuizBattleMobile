import 'dart:developer';

import 'package:dio/dio.dart';

class DioLoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("\x1B[33m[REQ ${options.method.toUpperCase()}]\x1B[0m");
    log("→ URL: ${options.uri}");

    if (options.headers.isNotEmpty) {
      log("\x1B[36m→ Headers:\x1B[0m");
      options.headers.forEach((k, v) {});
    }

    if (options.queryParameters.isNotEmpty) {
      log("\x1B[36m→ Query Parameters:\x1B[0m");
      options.queryParameters.forEach((k, v) => log('   $k: $v'));
    }

    if (options.data != null) {
      log("\x1B[36m→ Body:\x1B[0m");
      log("   ${options.data}");
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("\x1B[31m[ERROR ${err.response?.statusCode ?? 'N/A'}]\x1B[0m");
    log("→ URL: ${err.requestOptions.uri}");
    log("→ Error: ${err.message}");

    if (err.response != null) {
      log("→ Response: ${err.response!.data}");
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('\x1B[32m[RES ${response.statusCode}]\x1B[0m');
    log('→ URL: ${response.requestOptions.uri}');

    super.onResponse(response, handler);
  }
}
