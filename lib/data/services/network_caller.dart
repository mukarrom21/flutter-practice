import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:practice_with_ostad/data/models/network_response.dart';

class NetworkCaller {
  /// HTTP Get Request
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      final Response response = await get(uri);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = await jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          response: decodeData,
        );
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  /// HTTP Post Request
  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      Response response = await post(
        uri,
        headers: {
          'Content-Type': "application/json",
        },
        body: jsonEncode(data),
      );

      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          response: decodeData,
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printResponse(String url, Response response) {
    debugPrint(
      'URL: $url \nRESPONSE CODE: ${response.statusCode} \nRESPONSE: ${response.body}',
    );
  }
}
