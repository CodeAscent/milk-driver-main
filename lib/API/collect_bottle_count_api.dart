import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/API/get_order_api.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';
import 'package:water/utils/widgets/app_snackbar.dart';

import 'API_handler/api_base_handler.dart';

updateCollectedBottle(
    String isCollected, String count, dynamic id, String reason) async {
  HomeController homeController = Get.put(HomeController());

  homeController.updateLoading.value = true;

  http.Response response = await ApiHandler.post(
    ApiUrls.collectBottles,
    withToken: true,
    body: {
      "is_collected": isCollected,
      "collected_count": count,
      "delivery_id": id,
      'bottle_reason': reason,
    },
    useToken: true,
  );

  print("COLLECT BOTTLE ::: ${response.statusCode}");
  print("COLLECT BOTTLE ::: ${response.body}");
  Get.closeCurrentSnackbar();

  if (response.statusCode == 200) {
    homeController.updateLoading.value = false;

    appSnackBar(
      title: "Successfully",
      message: jsonDecode(response.body)['message'],
      success: true,
    );
    getOrderApi(url: "", orderHistory: false);
  } else {
    homeController.updateLoading.value = false;
    appSnackBar(
      title: "Failed",
      message: jsonDecode(response.body)['message'],
      success: false,
    );
  }
}
