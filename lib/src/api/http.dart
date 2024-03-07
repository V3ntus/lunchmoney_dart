import 'dart:convert';

import 'package:dio/dio.dart';

class HTTPException implements Exception {
  final List<String> errors;

  HTTPException(this.errors);

  @override
  String toString() {
    return "HTTP error(s) occurred: ${errors.join(", ")}";
  }
}

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
  /// The API should return a JSON serializable object on normal error and success.
  Future<dynamic> request(
    String method,
    String url, {
    Map<String, dynamic>? queryParameters,
    String? content,
    Map<String, dynamic>? json,
  }) async {
    final response = (await _dio.request(
      url,
      queryParameters: queryParameters,
      options: Options(
        method: method,
        headers: {
          "Authorization": "Bearer $_accessToken",
        },
      ),
    ))
        .data;
    if (response is Map<String, dynamic>) {
      // If there are errors present, throw them as an exception
      if (response.containsKey("errors")) {
        throw HTTPException(response["errors"]);
      }
      return response;
    } else {
      return jsonDecode(response);
    }
  }
}
