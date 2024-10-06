import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/model/get_order_model.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';

Future getOrderApi({url, orderHistory}) async {
  HomeController homeController = Get.put(HomeController());

  try {
    if (url.toString() == "" || url.toString() == null) {
      homeController.orderLoading.value = true;
    } else {
      homeController.paginationLoading.value = true;
    }

    var apiUrl = "";

    if (url.toString() == "" && orderHistory == false) {
      apiUrl = ApiUrls.orderList;
    } else if (url.toString() == "" && orderHistory == true) {
      apiUrl = '${ApiUrls.orderList}?type=past';
    } else {
      apiUrl = url.toString();
    }

    print("This is Api url order function $apiUrl");

    http.Response response = await ApiHandler.get(
      apiUrl,
      useBaseUrl: url.toString() == "" || url.toString() == null ? true : false,
    );
    // print("ORDER LIST ::: ${response.statusCode}");
    print(response.body);
    print("ORDER LIST::: ${response.body}");

    Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (url.toString() == "" || url.toString() == null) {
        homeController.orderList.value = [];
      }

      GetOrderModel getOrderModel = getOrderModelFromJson(response.body);

      // ignore: avoid_function_literals_in_foreach_calls

      dynamic data = responseData['data'];

      if (data is Map && data.isEmpty) {
        homeController.orderList.value = [];
        homeController.orderLoading.value = false;
        return;
      }
      getOrderModel.data!.data!.forEach((element) {
        homeController.orderList.add(element);
      });

      homeController.nextUrl.value = getOrderModel.data!.nextPageUrl.toString();
      homeController.orderLoading.value = false;
      if (getOrderModel.data!.nextPageUrl.toString() != "null") {
        homeController.isPaging.value = true;
      }

      homeController.paginationLoading.value = false;
    } else {
      homeController.orderLoading.value = false;
    }
  } catch (e) {
  } finally {
    homeController.paginationLoading.value = false;
  }
}

Future getOrderDetail({url}) async {
  // HomeController homeController = Get.put(HomeController());

  // if (url.toString() == "" || url.toString() == null) {
  //   homeController.orderLoading.value = true;
  // } else {
  //   homeController.paginationLoading.value = true;
  // }

  // ignore: prefer_interpolation_to_compose_strings
  var apiUrl = "${ApiUrls.orderDetail}/" + url;

  http.Response response = await ApiHandler.get(
    apiUrl,
  );

  if (response.statusCode == 200) {
    Datum getOrderModel = Datum.fromJson(json.decode(response.body)['data']);
    // ignore: avoid_function_literals_in_foreach_calls
    return getOrderModel;
  }
}
