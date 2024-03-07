import 'dart:convert';

import 'package:dio/dio.dart';

/// Thrown when the API sends an unexpected response.
class UnknownResponseError extends Error {
  final String message;

  UnknownResponseError(this.message);
}

/// Generic HTTP error
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
      // If there are error(s) present, throw as an exception
      if (response.containsKey("errors")) {
        throw HTTPException(response["errors"]);
      }
      if (response.containsKey("error")) {
        throw HTTPException([response["error"]]);
      }
      return response;
    } else {
      try {
        return jsonDecode(response);
      } on FormatException {
        return response;
      }
    }
  }
}
