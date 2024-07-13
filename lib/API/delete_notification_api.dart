import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_urls.dart';

import 'API_handler/api_base_handler.dart';
import 'get_notification_count_api.dart';

deleteNotification() async {
  http.Response response =
      await ApiHandler.get(ApiUrls.deleteNotification, useBaseUrl: true);

  print("DELETE NOTIFICATION ::: ${response.statusCode}");
  print("DELETE NOTIFICATION ::: ${response.body}");

  if (response.statusCode == 200) {
    getNotificationCount();
  }
}
