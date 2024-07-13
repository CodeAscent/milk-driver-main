import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/API/get_profile_api.dart';
import 'package:water/screen/home_screen/controller/home_controller.dart';
import 'package:water/utils/widgets/app_snackbar.dart';

import 'API_handler/api_base_handler.dart';

updateProfile() async {
  HomeController homeController = Get.put(HomeController());

  homeController.updateLoading.value = true;

  http.Response response = await ApiHandler.post(
    ApiUrls.updateProfile,
    withToken: true,
    body: {
      "name": homeController.nameController.value.text,
      "email": homeController.emailController.value.text,
      "lang_code": "en",
      "phone": homeController.phoneController.value.text
    },
    useToken: true,
  );

  print("LOGIN ::: ${response.statusCode}");
  print("LOGIN ::: ${response.body}");

  if (response.statusCode == 200) {
    await getProfileApi();
    appSnackBar(
      title: "Successfully",
      message: jsonDecode(response.body)['message'],
      success: true,
    );
  } else {
    homeController.updateLoading.value = false;
    appSnackBar(
      title: "Failed",
      message: jsonDecode(response.body)['message'],
      success: false,
    );
  }
}
