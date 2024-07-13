import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/model/get_notification_model.dart';
import 'package:water/screen/notification_screen/controller/notification_controller.dart';

getNotificationApi({url}) async {
  NotificationController notificationController =
      Get.put(NotificationController());

  if (url.toString() == "" || url.toString() == null) {
    notificationController.notificationLoading.value = true;
  } else {
    notificationController.paginationLoading.value = true;
  }

  var apiUrl = "";

  if (url.toString() == "") {
    apiUrl = ApiUrls.notification;
  } else {
    apiUrl = url.toString();
  }

  http.Response response = await ApiHandler.get(
    apiUrl,
    useBaseUrl: url.toString() == "" || url.toString() == null ? true : false,
  );
  print("NOTIFICATION LIST ::: ${response.statusCode}");
  print("NOTIFICATION LIST::: ${response.body}");

  if (response.statusCode == 200) {
    if (url.toString() == "" || url.toString() == null) {
      notificationController.notificationList.value = [];
    }
    GetNotificationModel getNotificationModel =
        getNotificationModelFromJson(response.body);

    // ignore: avoid_function_literals_in_foreach_calls
    getNotificationModel.data!.data!.forEach((element) {
      notificationController.notificationList.add(element);
    });
    notificationController.nextUrl.value =
        getNotificationModel.data!.nextPageUrl.toString();

    if (getNotificationModel.data!.nextPageUrl.toString() != "null") {
      notificationController.isPaging.value = true;
    }
    notificationController.notificationLoading.value = false;
    notificationController.paginationLoading.value = false;
  } else {
    notificationController.notificationLoading.value = false;
    notificationController.paginationLoading.value = false;
  }
}
