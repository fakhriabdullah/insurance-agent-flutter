import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:insurance_agent_flutter/config/config.dart';
class Client {
  Dio init() {
    Dio dio = Dio();
    dio.interceptors.add(ApiInterceptors());
    dio.options.baseUrl = Config.apiUrl;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.followRedirects = true;
    return dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");
    log("Headers:");
    options.headers.forEach((k, v) => log('$k: $v'));

    log("queryParameters:");
    options.queryParameters.forEach((k, v) => log('$k: $v'));

    if (options.data != null) {
      log("Body: ${options.data}");
    }
    log("--> END ${options.method.toUpperCase()}");

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("${err.response != null ? err.response?.data : 'Unknown Error'}");
    log("<-- End error");
    
    return handler.next(err); // continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Headers:");
    response.headers.forEach((k, v) => log('$k: $v'));
    log("Response: ${response.data}");
    log("<-- END HTTP");
    return handler.next(response);
  }
}
