import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:water/API/get_notification_count_api.dart';
import 'package:water/API/get_order_api.dart';
import 'package:water/API/get_order_status_api.dart';
import 'package:water/API/get_profile_api.dart';
import 'package:water/model/get_order_status.dart';

class AuthController extends GetxController {
  RxBool loading = false.obs;
  RxBool forgotLoading = false.obs;
  RxString token = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString phone = "".obs;
  RxString image = "".obs;
  RxString deviceToken = "".obs;
  RxInt notificationCount = 0.obs;

  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> forgotEmailController = TextEditingController().obs;
  Rx<TextEditingController> passController = TextEditingController().obs;

  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;

  RxList<OrderStatus> orderStatusList = <OrderStatus>[].obs;

  // profile

  RxBool updateProfile = false.obs;
  RxBool logOutLoading = false.obs;

  getFromPrefs() async {
    //  deviceToken.value = (await FirebaseMessaging.instance.getToken())!;
    final box = GetStorage();
    if (box.read("token") != null) {
      token.value = await box.read("token");
      name.value = await box.read("name");
      email.value = await box.read("email");
      phone.value = await box.read("phone");
      if (box.hasData('image')) {
        image.value = await box.read("image");
      }
    }
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    getProfileApi();
    getOrderApi(url: "", orderHistory: false);
    getNotificationCount();
    getOrderStatusApi();
    super.onReady();
  }

  @override
  void onInit() async {
    getFromPrefs();
    // TODO: implement onInit
    super.onInit();
  }
}
