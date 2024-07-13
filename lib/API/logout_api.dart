import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/main.dart';
import 'package:water/screen/login_screen/login.dart';
import 'package:water/utils/widgets/app_snackbar.dart';

import '../utils/uttil_helper.dart';

logOutService(context) async {
  authController.logOutLoading.value = false;

  http.Response response = await ApiHandler.post(
    ApiUrls.logOut,
    withToken: false,
    useToken: true,
  );
  authController.logOutLoading.value = false;
  if (response.statusCode == 200) {
    final box = GetStorage();
    box.erase();
    authController.onClose();
    Get.offAll(() => const LoginScreen());
    appSnackBar(
      title: "Successfully",
      message: UtilsHelper.getString(context, 'logout_successfully'),
      success: true,
    );
  } else {
    authController.loading.value = false;
    appSnackBar(
      title: "Failed",
      message: UtilsHelper.getString(context, "something_went_wrong"),
      success: false,
    );
  }
}
