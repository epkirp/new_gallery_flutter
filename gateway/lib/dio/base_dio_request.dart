import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gateway/helpers/internet_connection_helper.dart';

class ApiErrorHandler {
  static Future<E> sendRequest<E>({
    required Future<Response<dynamic>> request,
    required E Function(Map<String, dynamic>) converter,
  }) async {
    final hasConnect = await InternetConnection.hasInternetConnectivity();
    if (hasConnect) {
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
    } else {
      throw NoInternetConnection();
    }
  }

  static Exception handleError(Response<dynamic>? errorResponse) {
    if (errorResponse == null) {
      return UnknownError();
    }

    switch (errorResponse.statusCode) {
      case 404:
        return NotFound(jsonDecode(errorResponse.data));
      case 400:
        return BadRequest(errorResponse.data['error_description']);
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

class BadRequest implements Exception {
  final String? message;

  BadRequest(this.message);
}

class NoInternetConnection implements Exception {}

class UnknownError implements Exception {}
