import 'package:get/get.dart';
import 'package:water/model/get_notification_model.dart';

class NotificationController extends GetxController {
  RxBool notificationLoading = false.obs;
  RxBool paginationLoading = false.obs;
  RxList<Notification> notificationList = <Notification>[].obs;

  RxString nextUrl = "".obs;
  RxBool isPaging = false.obs;
}
