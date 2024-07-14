import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:water/main.dart';
import 'package:water/model/get_order_model.dart';

ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

class HomeController extends GetxController {
  RxBool orderLoading = false.obs;
  RxBool paginationLoading = false.obs;
  RxString nextUrl = "".obs;
  RxBool isPaging = false.obs;

  RxList<Datum> orderList = <Datum>[].obs;

  // orderDetail

  RxBool detailLoading = false.obs;

  // profile

  RxBool updateLoading = false.obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;

  Rx<TextEditingController> isCollectedController = TextEditingController().obs;
  Rx<TextEditingController> collectedCountController =
      TextEditingController().obs;

  @override
  void onReady() {
    // TODO: implement onReady
    nameController.value.text = authController.name.value.toString();
    emailController.value.text = authController.email.value.toString();
    phoneController.value.text = authController.phone.value.toString();
    super.onReady();
  }

  initializeData() {
    nameController.value.text = authController.name.value.toString();
    emailController.value.text = authController.email.value.toString();
    phoneController.value.text = authController.phone.value.toString();
  }


 
}
