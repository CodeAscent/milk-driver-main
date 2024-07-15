import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/main.dart';

class ApiHandler {
  static Future<http.Response> get(String url, {bool useBaseUrl = true}) async {
    print("I am here");
    print(useBaseUrl ? ApiUrls.baseUrl + url : url);
    print(authController.token.value);
    http.Response response = await http.get(
      useBaseUrl ? Uri.parse(ApiUrls.baseUrl + url) : Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "api-token": authController.token.value
      },
    );
    print('---------->$response');
    return response;
  }

  static Future<http.Response> post(String url,
      {Map<String, dynamic>? body,
      bool? withToken,
      bool? useToken = true}) async {
    print(Uri.parse(ApiUrls.baseUrl + url));
    print(jsonEncode(body));
    http.Response response = await http.post(Uri.parse(ApiUrls.baseUrl + url),
        headers: useToken == true
            ? {
                "Content-Type": "application/json",
                "api-token": authController.token.value,
              }
            : {"Content-Type": "application/json"},
        body: jsonEncode(body));
    Logger().f(ApiUrls.baseUrl + url);
    return response;
  }

  static Future<http.Response> put(String url,
      {Map<String, dynamic>? body}) async {
    http.Response response = await http.put(Uri.parse(ApiUrls.baseUrl + url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + authController.token.value
        },
        body: jsonEncode(body));
    return response;
  }

  static Future<http.Response> delete(String url) async {
    print(Uri.parse(ApiUrls.baseUrl + url));
    http.Response response = await http.delete(Uri.parse(ApiUrls.baseUrl + url),
        headers: {"api-token": authController.token.value});
    return response;
  }
}
