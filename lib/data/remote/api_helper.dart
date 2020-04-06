import 'dart:io';

import 'package:covid19app/utils/constants.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  Dio get herokuApi {
    BaseOptions options = createDefaultApiOptions(Constants.HEROKU_ENDPOINT);

    return new Dio(options);
  }

  BaseOptions createDefaultApiOptions(String baseUrl) {
    return new BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {HttpHeaders.contentTypeHeader: "application/json"}
    );
  }
}