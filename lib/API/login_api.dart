import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/API/get_notification_count_api.dart';
import 'package:water/API/get_order_api.dart';
import 'package:water/API/get_order_status_api.dart';
import 'package:water/API/get_profile_api.dart';
import 'package:water/Utils/widgets/app_snackbar.dart';
import 'package:water/main.dart';
import 'package:water/screen/home_screen/home_screen.dart';

import '../utils/uttil_helper.dart';
import 'API_handler/api_base_handler.dart';

loginService(context) async {
  if (authController.passController.value.text.toString() == '' &&
      authController.emailController.value.text.toString() == '') {
    appSnackBar(
      title: UtilsHelper.getString(context, "Error"),
      message: 'Fields are empty',
      success: false,
    );
  } else if (authController.passController.value.text.toString() == '' ||
      authController.emailController.value.text.toString() == '') {
    appSnackBar(
      title: UtilsHelper.getString(context, "Error"),
      message: authController.emailController.value.text.toString() == ''
          ? UtilsHelper.getString(context, "please_enter_mobile_number")
          : UtilsHelper.getString(context, "enter_password"),
      success: false,
    );
  } else {
    authController.loading.value = true;

    final box = GetStorage();

    // http.Response response = await ApiHandler.post(
    //   "${ApiUrls.login}?phone=${authController.emailController.value.text.toString()}&password=${authController.passController.value.text}",
    //   withToken: false,
    //   body: {
    //     "username": "admin",
    //     "password": "123456",
    //   },
    //   useToken: false,
    // );
    http.Response response = await ApiHandler.post(
      ApiUrls.login,
      withToken: false,
      body: {
        "phone": authController.emailController.value.text,
        "password": authController.passController.value.text,
        "player_id": OneSignal.User.pushSubscription.id
      },
      useToken: false,
    );

    print(response.body);
    print(jsonDecode(response.body)['data']['api_token']);
    authController.loading.value = false;
    if (response.statusCode == 200) {
      box.write('token', jsonDecode(response.body)['data']['api_token']);
      authController.token.value =
          jsonDecode(response.body)['data']['api_token'];
      getProfileApi();
      getOrderApi(url: "", orderHistory: false);
      getNotificationCount();
      getOrderStatusApi();
      authController.loading.value = false;
      Get.offAll(() => const HomeScreen());

      // appSnackBar(
      //   title: UtilsHelper.getString(context, "Success"),
      //   message:
      //       "${UtilsHelper.getString(context, "sign_in")} ${UtilsHelper.getString(context, "Success")}",
      //   success: true,
      // );
    } else {
      print(jsonDecode(response.body).toString());
      authController.loading.value = false;
      appSnackBar(
        title: UtilsHelper.getString(context, "Error"),
        message: jsonDecode(response.body)['message'],
        success: false,
      );
    }
  }
}
