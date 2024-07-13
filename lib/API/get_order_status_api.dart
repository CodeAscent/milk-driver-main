import 'package:http/http.dart' as http;
import 'package:water/API/API_handler/api_base_handler.dart';
import 'package:water/API/API_handler/api_urls.dart';
import 'package:water/main.dart';
import 'package:water/model/get_order_status.dart';

getOrderStatusApi() async {
  http.Response response =
      await ApiHandler.get(ApiUrls.orderStatusList, useBaseUrl: true);
  print("ORDER STATUS LIST ::: ${response.statusCode}");
  print("ORDER STATUS LIST::: ${response.body}");

  authController.orderStatusList.clear();

  if (response.statusCode == 200) {
    OrderStatusModel orderStatusModel = orderStatusModelFromJson(response.body);

    if (orderStatusModel.data!.isNotEmpty) {
      for (var element in orderStatusModel.data!) {
        authController.orderStatusList.add(element);
      }
    }
  }
}
