import 'dart:convert';

import 'package:dio/dio.dart';

class HTTPClient {
  final String _accessToken;

  HTTPClient({required String accessToken}) : _accessToken = accessToken;

  // Initiate the Dio instance
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://dev.lunchmoney.app/v1/",
    ),
  );

  /// Initiate a request. The access token gets injected into the Headers automatically.
  Future<Map<String, dynamic>> request(
    String method,
    String url, {
    String? content,
    Map<String, dynamic>? json,
  }) async {
    final response = (await _dio.request(url,
            options: Options(method: method, headers: {
              "Authorization": "Bearer $_accessToken",
            })))
        .data;
    if (response is Map<String, dynamic>) {
      return response;
    } else {
      return jsonDecode(response);
    }
  }
}
