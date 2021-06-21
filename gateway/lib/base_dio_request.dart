import 'dart:convert';

import 'package:dio/dio.dart';

class ApiErrorHandler {
  static Future<E> sendRequest<E>({
    required Future<Response<dynamic>> request,
    required E Function(Map<String, dynamic>) converter,
  }) async {
    try {
      final Response response = await request;
      if (!response.statusCode.toString().startsWith('2')) {
        throw handleError(response);
      } else {
        return converter(response.data);
      }
    } on DioError catch (e) {
      throw handleError(e.response);
    }
  }

  static Exception handleError(Response<dynamic>? errorResponse) {
    if (errorResponse == null) {
      return UnknownError();
    }

    switch (errorResponse.statusCode) {
      case 404:
        return NotFound(jsonDecode(errorResponse.data));
      case 500:
      case 502:
        return ServiceUnavailable();
      default:
        return UnknownError();
    }
  }
}

class ServiceUnavailable implements Exception {}

class NotFound implements Exception {
  final String? message;

  NotFound(this.message);
}

class UnknownError implements Exception {}
