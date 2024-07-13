import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/main.dart';

getNotificationCount() async {
  http.Response response =
      await ApiHandler.get(ApiUrls.countNotification, useBaseUrl: true);

  print("GET COUNT NOTIFICATION ::: ${response.statusCode}");
  print("GET COUNT NOTIFICATION ::: ${response.body}");

  if (response.statusCode == 200) {
    authController.notificationCount.value = jsonDecode(response.body)['data'];
  }
}
