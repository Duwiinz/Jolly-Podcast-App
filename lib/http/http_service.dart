import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../storage/app_preferences.dart';
import 'exception.dart';

class HttpClientService {
  final AppPreferences prefs;

  HttpClientService(this.prefs);

  Future<http.Response> get(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: _headers(),
    );

    _handleResponse(response);
    return response;
  }

  Future<http.Response> post(
    String url, {
    Map<String, dynamic>? body,
  }) async {
    log("HttpClientService: POST request to $url with body: $body", name: "HttpClientService");

    final response = await http.post(
      Uri.parse(url),
      headers: _headers(),
      body: jsonEncode(body),
    )      .timeout(const Duration(seconds: 15));

  log("HttpClientService: Response status: ${response.statusCode}", name: "HttpClientService");
  log("HttpClientService: Response body: ${response.body}", name: "HttpClientService");


    _handleResponse(response);
    return response;
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      if (prefs.token != null)
        'Authorization': 'Bearer ${prefs.token}',
    };
  }

  void _handleResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
      return;

    case 400:
      throw BadRequestException('Bad request');

    case 401:
      prefs.clearSession();
      throw UnauthorizedException('Session expired');

    case 403:
      throw ForbiddenException('Access denied');

    case 404:
      throw NotFoundException('Resource not found');

    case 503:
      throw ServiceUnavailableException(
        'Service temporarily unavailable',
      );

    default:
      throw ServerException(
        'Server error occurred',
        statusCode: response.statusCode,
      );
  }
}

}
