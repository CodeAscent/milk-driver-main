import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/main.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';

getProfileApi() async {
  final box = GetStorage();

  HomeController homeController = Get.put(HomeController());

  http.Response response =
      await ApiHandler.get(ApiUrls.profile, useBaseUrl: true);
  print("GET PROFILE ::: ${response.statusCode}");
  print("GET PROFILE ::: ${response.body}");
  if (response.statusCode == 200) {
    box.write('name', jsonDecode(response.body)['data']['name']);
    authController.name.value =
        jsonDecode(response.body)['data']['name'].toString();

    box.write('email', jsonDecode(response.body)['data']['email']);
    authController.email.value =
        jsonDecode(response.body)['data']['email'].toString();

    box.write('phone', jsonDecode(response.body)['data']['phone']);
    authController.phone.value =
        jsonDecode(response.body)['data']['phone'].toString();

    box.write('image', jsonDecode(response.body)['data']['image']);
    authController.image.value =
        jsonDecode(response.body)['data']['image'].toString();
    homeController.updateLoading.value = false;
  }
}
